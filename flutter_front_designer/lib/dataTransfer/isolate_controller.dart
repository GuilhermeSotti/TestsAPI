import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import 'constants.dart';

class DataTransferIsolateController extends ChangeNotifier {

  Isolate? _isolate;
  late ReceivePort _incomingReceivePort;
  late SendPort _outgoingSendPort;

  final currentProgress = <String>[];
  RunningRequest runningTest = RunningRequest.pause;
  Stopwatch _timer = Stopwatch();
  double progressPercent = 0;

  bool get isRunning => runningTest != RunningRequest.pause;

  DataTransferIsolateController(){
    createIsolate();
    listen();
  }

  Future<void> createIsolate() async {
    _incomingReceivePort = ReceivePort();
    _isolate = await Isolate.spawn(
        _secondIsolateEntryPoint, _incomingReceivePort.sendPort
    );
  }

  void listen() {
    _incomingReceivePort.listen(
          (dynamic message) {
        if (message is SendPort) {
          _outgoingSendPort = message;
        }

        switch(message){
          case int:
            currentProgress.insert(0,
              '$message % - '
                  '${_timer.elapsedMilliseconds / 1000} '
                  'seconds',
            );
            progressPercent = message / 100;
            break;
          case String:
            if (message.equals('done')){
              runningTest = RunningRequest.pause;
              _timer.stop();
            }
            break;
          default:
            throw Exception;
        }
        notifyListeners();
      },);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
  }

  void generateOnSecondaryIsolate() {
    if (isRunning) return;
    runningTest = RunningRequest.traffic;
    currentProgress.clear();

    _timer = Stopwatch();
    _timer.start();
    _outgoingSendPort.send('start'); // Result

    notifyListeners();
  }

  Future<void> generateRandomNumbers(bool transferableTypedData) async {
    if (isRunning) return;

    if (transferableTypedData) {
      runningTest = RunningRequest.finnish;
    } else {
      runningTest = RunningRequest.start;
    }

    var random = Random();
    currentProgress.clear();
    _timer.reset();
    _timer.start();

    var randNumArray = <int>[];
    for (var i = 0; i < 100; i++) {
      randNumArray.clear();
      for (var j = 0; j < Constant.countNumber; j++){
        randNumArray.add(random.nextInt(100));
      }
      if(transferableTypedData) {
        final transferable =
        TransferableTypedData.fromList(
          [Int32List.fromList(randNumArray)],
        );
        await sendNumbers(transferable);
      } else {
        await sendNumbers(randNumArray);
      }
    }
  }

  Future<void> sendNumbers(dynamic numList) async {
    return Future<void> (() => _outgoingSendPort.send(numList));
  }
}

Future<void> _secondIsolateEntryPoint(SendPort sendPort) async {
  var receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  var length = 1;

  receivePort.listen(
        (dynamic message) async {

      if (message is String && message == 'start') {
        await generateAndSum(
          sendPort, createNum(), length,
        );
        sendPort.send('done'); // Result

      } else if (message is TransferableTypedData) {
        await generateAndSum(
          sendPort, message.materialize().asInt32List(), length,
        );
        length++;

      } else if (message is List<int>) {
        await generateAndSum(
          sendPort, message, length,
        );
        length++;

      }

      if (length == 101){
        sendPort.send('done'); // Result
        length = 1;
      }
    },
  );
}

Iterable<int> createNum() sync* {
  var random = Random();
  for (int i = 0; i < Constant.countNumber; i++){
    yield random.nextInt(100);
  }
}

Future<int> generateAndSum(
    SendPort sendPort,
    Iterable<int> iterable,
    int length,
    ) async {
  var sum = 0;
  var count = 1;

  for(var x in iterable) {
    sum += x;
    if (count % Constant.countNumber == 0) {
      sendPort.send((count ~/ Constant.countNumber) * length);
    }
  }
  count++;
  return sum;
}
