import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';

class MyButton extends StatelessWidget {
  final icon;
  final function;

  MyButton({required this.icon, required this.function});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(11),
      child: HoldDetector(
        onHold: function,
        enableHapticFeedback: true,
        child: Container(
          color: Colors.grey,
          width: 50,
          height: 50,
          child: Center(
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
