import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {

  final int time;

  TimerWidget(this.time);

  String formatTime(int seconds){
    int m = seconds ~/60;
    int s = seconds % 60;

    String m_s = m < 9 ? '0' + m.toString() : m.toString();
    String s_s = s < 10 ? '0' + s.toString() : s.toString();
    return m_s + ":" + s_s;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        formatTime(time),
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }
}
