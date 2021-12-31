import 'package:fl_scrcpy/fl_scrcpy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curiosity/flutter_curiosity.dart';
import 'package:flutter_waya/flutter_waya.dart';

void main() {
  runApp(const ExtendedWidgetsApp(home: _App()));
}

class _App extends StatefulWidget {
  const _App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<_App> {
  @override
  void initState() {
    super.initState();
    Curiosity().desktop.focusDesktop().then((value) {
      if (value) Curiosity().desktop.setDesktopSize(const Size(600, 600));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const ExtendedScaffold(body: FlScrcpy());
  }
}
