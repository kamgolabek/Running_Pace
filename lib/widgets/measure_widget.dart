import 'package:flutter/material.dart';

class MeasureWidget extends StatelessWidget {
  final Function changeStateHandler;
  final String state;

  MeasureWidget(this.changeStateHandler, this.state);

  @override
  Widget build(BuildContext context) {

    bool start_isActive = (state == 'PAUSED' || state == 'STOPPED') ? true : false;
    final start_icon = IconButton(
        iconSize: 100,
        icon: Icon(
          Icons.arrow_right,
          color: start_isActive ?  Colors.green : Colors.green[100],
        ),
        onPressed: () => changeStateHandler('RUNNING'));

    bool pause_isActive = (state == 'RUNNING') ? true : false;
    final pause_icon = IconButton(
        iconSize: 100,
        icon: Icon(
          Icons.pause,
          color: pause_isActive ?  Colors.orange : Colors.orange[100],
        ),
        onPressed: () => changeStateHandler('PAUSED'));

    bool stop_isActive = (state == 'PAUSED' || state == 'RUNNING') ? true : false;
    final stop_icon = IconButton(
        iconSize: 100,
        icon: Icon(
          Icons.stop,
          color: stop_isActive ?  Colors.red : Colors.red[100],
        ),
        onPressed: () => changeStateHandler('STOPPED'));

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          start_icon,
          pause_icon,
          stop_icon,
        ],
      ),
    );
  }
}
