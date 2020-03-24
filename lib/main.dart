import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/timer.dart';
import './widgets/measure_widget.dart';
import 'package:vibration/vibration.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Running Pace',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Running Pace'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String measure_state = 'STOPPED';

  Timer _timer;

  int _time = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _time += 1;
        },
      ),
    );
  }

  void _changeMeasureState(String state) {
    setState(() {
      measure_state = state;

      switch (measure_state) {
        case 'RUNNING':
          startTimer();
          break;
        case 'PAUSED':
          _timer.cancel();
          break;
        case 'STOPPED':
          _timer.cancel();
          _time = 0;
          break;
        default:
      }
    });

    if (state == 'RUNNING') {
      if (Vibration.hasVibrator() != null) {
        Vibration.vibrate(
            pattern: [50, 100, 50, 200, 50, 100, 50, 200, 50, 100, 50, 200],
            intensities: [1, 255]);
      }
    } else {
      Vibration.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/running.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TimerWidget(_time),
            MeasureWidget(_changeMeasureState, measure_state),
          ],
        ),
      ),
    );
  }
}
