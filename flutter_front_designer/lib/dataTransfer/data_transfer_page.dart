import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show BuildContext, Card, Colors, Column, Divider, ElevatedButton, Key, LinearProgressIndicator, ListTile, MainAxisSize, SafeArea, StatelessWidget, Theme, Widget;
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, Provider;

import 'constants.dart';
import 'isolate_controller.dart';

class DataTransferPageStarter extends StatelessWidget {

  const DataTransferPageStarter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (context) => DataTransferIsolateController(),
      child: const DataTransferLayoutPage(),
    );
  }
}

class DataTransferLayoutPage extends StatelessWidget {
  const DataTransferLayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DataTransferIsolateController>(context);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(
              'Number Generator Progress',
              style: Theme.of(context).textTheme.headline6,
            ),
            padding: const EdgeInsets.all(8),
          ),
          LinearProgressIndicator(
            value: controller.progressPercent,
            backgroundColor: Colors.grey[200],
          ),
          const Expanded(
            child: RunningList(),
          ),
          Column(
            children:[
              ElevatedButton(
                child: const Text('Transfer Data to 2nd Isolate'),
                style: ElevatedButton.styleFrom(
                  primary: (controller.runningTest == RunningRequest.start)
                      ? Colors.blueAccent
                      : Colors.green[300],
                  ),
                onPressed: () => controller.generateRandomNumbers(false),
              ),
              ElevatedButton(
                child: const Text('Transfer Data with TransferableTypedData'),
                style: ElevatedButton.styleFrom(
                    primary: (controller.runningTest == RunningRequest.finnish)
                        ? Colors.blueAccent
                        : Colors.grey[300]
                ),
                onPressed: () => controller.generateRandomNumbers(true),
              ),
              ElevatedButton(
                child: const Text('Generate on 2nd Isolate'),
                style: ElevatedButton.styleFrom(
                    primary: (controller.runningTest == RunningRequest.traffic)
                        ? Colors.blueAccent
                        : Colors.grey[300]
                ),
                onPressed: controller.generateOnSecondaryIsolate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RunningList extends StatelessWidget {
  const RunningList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress =
        Provider.of<DataTransferIsolateController>(context).currentProgress;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: ListView.builder(
        itemCount: progress.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                child: ListTile(
                  title: Text(progress[index]),
                ),
                color: Colors.lightGreenAccent,
              ),
              const Divider(
                color: Colors.blue,
                height: 3,
              ),
            ],
          );
        },
      ),
    );
  }
}
