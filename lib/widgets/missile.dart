import 'package:flutter/material.dart';

class Missile extends StatelessWidget {
  double missileX;
  double missileY = 1;
  double missileHeight;

  Missile({required this.missileX, required this.missileHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX, missileY),
      child: Container(
        width: 2,
        height: missileHeight,
        color: Colors.red,
      ),
    );
  }
}
