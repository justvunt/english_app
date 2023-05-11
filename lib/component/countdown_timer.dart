import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback activeButton;
  CountdownTimer({required this.duration, required this.activeButton});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer _timer = Timer(Duration(days: 0), () { });
  Duration _remainingTime = Duration(days: 0);


  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) { 
      setState(() {
        if(_remainingTime.inSeconds <= 0 ){
          widget.activeButton();
          _timer.cancel();
        }else{
          _remainingTime = Duration(seconds: _remainingTime.inSeconds - 1);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int hours = _remainingTime.inHours;
    int minutes = _remainingTime.inMinutes.remainder(60);
    int seconds = _remainingTime.inSeconds.remainder(60);
    if(hours < 0) hours = 0;
    if(minutes < 0) minutes = 0;
    if(seconds < 0) seconds = 0;
    return Text('$hours: ${minutes. toString() .padLeft(2, '0')}: ${seconds.toString() .padLeft(2, '0')}');
  }
}