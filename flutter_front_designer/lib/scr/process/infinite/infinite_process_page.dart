import 'package:flutter/material.dart'
    show BoxDecoration, BuildContext, ButtonBar, Card, Colors, Column, DecoratedBox,
    Divider, EdgeInsets, ElevatedButton, Expanded, Key, ListTile, ListView, MainAxisAlignment,
    MainAxisSize, Padding, Radio, Row, SafeArea, StatelessWidget, Switch, Text, Theme, Widget;

import 'package:provider/provider.dart' show ChangeNotifierProvider, Provider;

import 'isolate_controller.dart' show InfiniteProcessIsolateController;

class InfiniteProcessPageStarter extends StatelessWidget {
  const InfiniteProcessPageStarter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InfiniteProcessIsolateController(),
      child: const InfiniteProcessPage(),
    );
  }

}

class InfiniteProcessPage extends StatelessWidget{
  const InfiniteProcessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
      Provider.of<InfiniteProcessIsolateController>(context);

    // TODO: implement build
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Summation Results',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const Expanded(
            child: RunningListInfinite(),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Start'),
                    style: ElevatedButton.styleFrom(elevation: 8.0),
                    onPressed: () => controller.start,
                  ),
                  ElevatedButton(
                    child: const Text('Terminate'),
                    style: ElevatedButton.styleFrom(elevation: 8.0),
                    onPressed: () => controller.terminate,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                    value: !controller.paused,
                    onChanged: (_) => controller.pauseSwitch,
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.black,
                    inactiveTrackColor: Colors.deepOrangeAccent,
                    inactiveThumbColor: Colors.black,
                  ),
                  const Text('Pause/Resume'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 3; i++) ...[
                    Radio<int>(
                      value: i,
                      groupValue: controller.currentMultiplier,
                      onChanged: (val) => controller.setMultiplier(val!),
                    ),
                    Text('${i}x'),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RunningListInfinite extends StatelessWidget{
  const RunningListInfinite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<InfiniteProcessIsolateController>(context);
    var sums = controller.currentResult;

    // TODO: implement build
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: ListView.builder(
        itemCount: sums.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Card(
                child: ListTile(
                  leading: Text('${sums.length - index}.'),
                  title: Text('${sums[index]}'),
                ),
                color: (controller.created && !controller.paused)
                    ? Colors.lightGreenAccent
                    : Colors.deepOrangeAccent,
              ),
              const Divider(
                color: Colors.blue,
                height: 3,
              )
            ]
          );
        },
      )
    );
  }
}
