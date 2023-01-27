import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final playerX;
  MyPlayer({required this.playerX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX, 1),
      child: Container(
        height: 50,
        width: 50,
        color: Colors.green,
      ),
    );
  }
}
