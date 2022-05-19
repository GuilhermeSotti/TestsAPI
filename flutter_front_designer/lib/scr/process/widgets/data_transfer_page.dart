import 'package:flutter/cupertino.dart'
    show
        BoxDecoration,
        BuildContext,
        Column,
        Container,
        DecoratedBox,
        EdgeInsets,
        Expanded,
        ListView,
        MainAxisSize,
        SafeArea,
        StatelessWidget,
        Text,
        Widget;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Card,
        Colors,
        Column,
        Divider,
        ElevatedButton,
        Theme,
        LinearProgressIndicator,
        ListTile,
        MainAxisSize,
        SafeArea,
        StatelessWidget,
        Widget;
import 'package:provider/provider.dart' show ChangeNotifierProvider, Provider;

import '../../data/constants.dart' show RunningRequest;
import '../controllers/data_transfer_controller.dart'
    show DataTransferIsolateController;

class DataTransferPageStarter extends StatelessWidget {
  const DataTransferPageStarter({super.key});

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
  const DataTransferLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DataTransferIsolateController>(context);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Number Generator Progress',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          LinearProgressIndicator(
            value: controller.progressPercent,
            backgroundColor: Colors.grey[200],
          ),
          const Expanded(
            child: RunningListDataTransfer(),
          ),
          Column(
            children:[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: (controller.runningTest == RunningRequest.isolate)
                      ? Colors.blueAccent
                      : Colors.green[300],
                ),
                onPressed: () => controller.generateRandomNumbers(false),
                child: const Text('Transfer Data to 2nd Isolate'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary:
                        (controller.runningTest == RunningRequest.transferable)
                            ? Colors.blueAccent
                            : Colors.grey[300]),
                onPressed: () => controller.generateRandomNumbers(true),
                child: const Text('Transfer Data with TransferableTypedData'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: (controller.runningTest == RunningRequest.generate)
                        ? Colors.blueAccent
                        : Colors.grey[300]),
                onPressed: controller.generateOnSecondaryIsolate,
                child: const Text('Generate on 2nd Isolate'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RunningListDataTransfer extends StatelessWidget {
  const RunningListDataTransfer({super.key});

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
                color: Colors.lightGreenAccent,
                child: ListTile(
                  title: Text(progress[index]),
                ),
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
