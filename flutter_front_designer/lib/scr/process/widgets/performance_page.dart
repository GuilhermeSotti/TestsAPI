import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart'
    show
        Alignment,
        BuildContext,
        Center,
        Column,
        ConnectionState,
        Container,
        EdgeInsets,
        ElevatedButton,
        FutureBuilder,
        MainAxisSize,
        ScaffoldMessenger,
        SnackBar,
        State,
        StatefulWidget,
        Text,
        Widget;

import '../services/animation.dart' show SmoothAnimationWidgets;

class PerformancePage extends StatefulWidget {
  const PerformancePage({super.key});

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  Future<void> computeFuture = Future.value();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SmoothAnimationWidgets(),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                FutureBuilder(
                    future: computeFuture,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 8.0),
                      onPressed:
                          snapshot.connectionState == ConnectionState.done
                              ? () => handleComputeOnMain(context)
                              : null,
                      child: const Text('Compute on Main'),
                    );
                  },
                ),
                FutureBuilder(
                    future: computeFuture,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 8.0),
                      onPressed:
                          snapshot.connectionState == ConnectionState.done
                              ? () => handleComputeOnSecondary(context)
                              : null,
                      child: const Text('Compute on Secondary'),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleComputeOnMain(BuildContext context) {
    var future = computeOnMainIsolate()
    ..then((_) {
      var snackBar = const SnackBar(
        content: Text('Main Isolate Done!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    setState(() {
      computeFuture = future;
    });
  }

  Future<void> computeOnMainIsolate() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    fib(45);
  }

  void handleComputeOnSecondary(BuildContext context) {
    var future = computeOnSecondaryIsolate()
      ..then((_) {
        var snackBar = const SnackBar(
          content: Text('Secondary Isolate Done!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });

    setState(() {
      computeFuture = future;
    });
  }

  Future<void> computeOnSecondaryIsolate() async {
    await compute(fib, 45);
  }

  int fib(int n) {
    var a = n - 1;
    var b = n - 2;

    if(n == 1) {
      return 0;
    } else if (n == 0) {
      return 1;
    } else {
      return (fib(a) + fib(b));
    }
  }
}