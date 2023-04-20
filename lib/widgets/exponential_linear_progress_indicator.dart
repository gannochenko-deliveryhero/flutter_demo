import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ExponentialLinearProgressIndicator extends StatefulWidget {
  const ExponentialLinearProgressIndicator({super.key});

  @override
  ExponentialLinearProgressIndicatorState createState() =>
      ExponentialLinearProgressIndicatorState();
}

class ExponentialLinearProgressIndicatorState
    extends State<ExponentialLinearProgressIndicator> {
  late Timer _timer;
  double _value = 0.0;
  final Duration _interval = const Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(_interval, (timer) {
      if (_value >= 1.0) {
        timer.cancel();
      } else {
        setState(() {
          _value = 1 - (pow(1 - _value, 4) as double);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _value,
      // backgroundColor: Colors.grey[200],
      // valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }
}
