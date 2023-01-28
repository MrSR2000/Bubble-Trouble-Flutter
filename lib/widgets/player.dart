import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final playerX;
  final playerDirection;

  MyPlayer({required this.playerX, required this.playerDirection});

  String playerImg() {
    if (playerDirection == "left") {
      return "assets/left.png";
    } else if (playerDirection == "right") {
      return "assets/right.png";
    } else {
      return "assets/front.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX, 1),
      child: Container(
        height: 60,
        width: 45,
        // color: Colors.purple,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(playerImg()),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
