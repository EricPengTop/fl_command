import 'package:fl_command/fl_command.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _App(),
    ),
  );
}

class _App extends StatefulWidget {
  const _App();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<_App> {
  late AdbProcess adbProcess = AdbProcess();
  late ScrcpyProcess scrcpyProcess = ScrcpyProcess();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              'connect device',
              onPressed: () async {
                await adbProcess.connectDevice('192.168.40.46:7802');
              },
            ),
            const SizedBox(height: 20),
            Button(
              'remote device',
              onPressed: () async {
                List<DeviceInfoModel> devices = await adbProcess.getDevices(
                  deviceInfo: true,
                );
                debugPrint(devices.join());

                if (devices.isNotEmpty) {
                  scrcpyProcess.runScrcpy(['-s', devices.first.id]);
                }
              },
            ),
            const SizedBox(height: 20),
            Button(
              'disconnect',
              onPressed: () async {
                adbProcess.disconnect();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button(this.text, {this.onPressed, super.key});

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
