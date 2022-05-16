import 'dart:isolate' show Capability, Isolate, ReceivePort, SendPort;
import 'dart:math' show Random;

import 'package:flutter/cupertino.dart' show ChangeNotifier;
import '../../data/constants.dart' show Constant;

class InfiniteProcessIsolateController extends ChangeNotifier {
  Isolate? _isolate;
  late ReceivePort receivePort;
  late SendPort sendPort;
  Capability? capability;

  int _currentMultiplier = 1;
  final List<int> _currentResult = [];
  bool _created = false;
  bool _paused = false;

  int get currentMultiplier => _currentMultiplier;

  bool get created => _created;
  
  bool get paused => _paused;
  
  List<int> get currentResult => _currentResult;

  Future<void> createIsolate() async {
    receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
      _secondIsolateEntryPoint, receivePort.sendPort
    );
  }

  @override
  void dispose() {
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    super.dispose();
  }

  Future<void> start() async {
    if(_created == false &&  _paused == false){
      await createIsolate();
      listen();
      _created = true;
      notifyListeners();
    }
  }

  void listen() {
    receivePort.listen((dynamic message) {
      if(message is SendPort) {
        sendPort = message;
        sendPort.send(_currentMultiplier);
      } else if (message is int){
        setCurrentResult(message);
      }
    });
  }

  void terminate() {
    _isolate?.kill();
    _created = false;
    _currentResult.clear();
    notifyListeners();
  }

  void pauseSwitch(){
    if(_paused && capability != null) {
      _isolate?.resume(capability!);
    } else {
      capability = _isolate?.pause();
    }
    _paused = !_paused;
  }

  void setMultiplier(int newMultiplier) {
    _currentMultiplier = newMultiplier;
    sendPort.send(_currentMultiplier);
    notifyListeners();
  }

  void setCurrentResult(int newNum) {
    _currentResult.insert(0, newNum);
    notifyListeners();
  }
}

Future<void> _secondIsolateEntryPoint(SendPort sendPort) async {
  var multiplyValue = 1;
  var _isolate = ReceivePort();

  sendPort.send(_isolate.sendPort);
  _isolate.listen((dynamic message) {
    if (message is int) multiplyValue = message;
  });

  //This runs until the isolate is terminated
  while(true) {
    var sum = 0;

    for (var i = 0; i < Constant.countNumber; i++){
      sum += await doSomeWork();
    }
    sendPort.send(sum * multiplyValue);
  }
}

Future<int> doSomeWork() {
  var rng = Random();

  return Future(() {
    var sum = 0;

    for (var i = 0; i < 1000; i++) {
      sum += rng.nextInt(100);
    }

    return sum;
  });
}