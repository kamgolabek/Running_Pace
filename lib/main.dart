import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/timer.dart';
import './widgets/measure_widget.dart';
import 'package:vibration/vibration.dart';

void main()  {
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

  void _changeMeasureState(String state){
    setState(() {
       measure_state = state;
    });

    if(state == 'RUNNING'){
      if (Vibration.hasVibrator() != null) {
         Vibration.vibrate(pattern: [50, 100, 50, 200, 50, 100, 50, 200, 50, 100, 50, 200], intensities: [1, 255]);
      }
    }else{
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
            TimerWidget(),
            MeasureWidget(_changeMeasureState, measure_state),
          ],
        ),
      ),
    );
  }
}
