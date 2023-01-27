import 'package:flutter/material.dart';

class MyBubble extends StatelessWidget {
  double bubbleX;
  double bubbleY;

  MyBubble({required this.bubbleX, required this.bubbleY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(bubbleX, bubbleY),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      ),
    );
  }
}
