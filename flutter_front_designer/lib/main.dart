import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart'
    show MaterialApp, Rect, Size, WidgetsFlutterBinding, runApp;
import 'package:url_strategy/url_strategy.dart' show setHashUrlStrategy;
import 'package:window_size/window_size.dart'
    show getCurrentScreen, setWindowFrame, setWindowMaxSize, setWindowMinSize,
    setWindowTitle;

import 'scr/app.dart' show Main;

void main() {
  setHashUrlStrategy();
  setupWindow();
  runApp(const Main());
}

const double windowWidth = 1024;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Isolate Example');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}