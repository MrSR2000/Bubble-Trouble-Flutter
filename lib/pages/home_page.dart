import 'dart:async';

import 'package:bubble_trouble/pages/menu_page.dart';
import 'package:bubble_trouble/widgets/bubble.dart';
import 'package:bubble_trouble/widgets/button.dart';
import 'package:bubble_trouble/widgets/missile.dart';
import 'package:bubble_trouble/widgets/player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  static double playerX = 0;
  double missileX = playerX;
  double missileHeight = 10;
  bool missileShot = false;
  double bubbleX = 0;
  double bubbleY = 0;
  var bubbleDirectoin = direction.LEFT;
  String playerDirectoin = "stationary";

  @override
  void initState() {
    startGame();
    super.initState();
  }

  void moveLeft() {
    if (playerX - 0.1 < -1) {
    } else {
      setState(() {
        playerX -= 0.1;
        playerDirectoin = "left";
      });
    }
    //doesn't let missile travel where character travel
    if (!missileShot) {
      setState(() {
        missileX = playerX;
      });
    }
  }

  void moveRight() {
    if (playerX + 0.1 > 1) {
    } else {
      setState(() {
        playerX += 0.1;
        playerDirectoin = "right";
      });
    }

    //doesn't let missile travel where character travel
    if (!missileShot) {
      setState(() {
        missileX = playerX;
      });
    }
  }

  void shoot() {
    if (!missileShot) {
      Timer.periodic(Duration(milliseconds: 20), (timer) {
        //missile is fired
        missileShot = true;

        //check if missile is out of screen
        if (missileHeight + 10 > MediaQuery.of(context).size.height * 6 / 7) {
          missileShot = false;
          resetMissile();
          timer.cancel();
        } else {
          setState(() {
            missileHeight += 10;
          });
        }

        //check if missile hit the bubble
        if (bubbleY > heightToCoordinate(missileHeight) &&
            (bubbleX - missileX).abs() < 0.03) {
          resetMissile();
          bubbleY = 0;
          timer.cancel();
          // print('hit');
        }
      });
    }
  }

  void resetMissile() {
    // print('resetting missile');
    setState(() {
      missileX = playerX;
      missileShot = false;
      missileHeight = 0;
    });
  }

  //converting height to coordinate to find out collision of bubble and missile
  double heightToCoordinate(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 6 / 7;
    double position = 1 - 2 * (height / totalHeight);
    return position;
  }

  void startGame() {
    double time = 0;
    double height = 0;
    double velocity = 90;

    Timer.periodic(Duration(milliseconds: 10), (timer) {
      //quadratic equation that models a bounce (upside down parabola)
      height = -5 * time * time + velocity * time;

      //if ball reaches ground restart jump
      if (height < 0) {
        time = 0;
      }
      time += 0.1;

      setState(() {
        bubbleY = heightToCoordinate(height);
        // print(bubbleY);
      });

      //bounce in wall
      if (bubbleX - 0.005 < -1) {
        bubbleDirectoin = direction.RIGHT;
      } else if (bubbleX + 0.005 > 1) {
        bubbleDirectoin = direction.LEFT;
      }

      if (bubbleDirectoin == direction.RIGHT) {
        setState(() {
          bubbleX += 0.02;
        });
      } else if (bubbleDirectoin == direction.LEFT) {
        setState(() {
          bubbleX -= 0.02;
        });
      }

      //check if game over
      if (gameOver()) {
        print('game over');
        gameOverDialogue();
        timer.cancel();
      }
    });
  }

  gameOverDialogue() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MenuPage())),
              child: const Text('Goto Main-Menu'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                startGame();
              },
              child: const Text('play again'),
            )
          ],
        );
      },
    );
  }

  bool gameOver() {
    if ((bubbleX - playerX).abs() < 0.2 && bubbleY > 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7), BlendMode.dstATop),
                      image: const AssetImage("assets/background.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        MyBubble(bubbleX: bubbleX, bubbleY: bubbleY),
                        Missile(
                            missileX: missileX, missileHeight: missileHeight),
                        MyPlayer(
                          playerX: playerX,
                          playerDirection: playerDirectoin,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 74, 54, 47),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // MyButton(icon: Icons.play_arrow, function: startGame),
                  MyButton(
                    icon: Icons.arrow_back,
                    function: moveLeft,
                  ),
                  MyButton(
                    icon: Icons.arrow_upward,
                    function: shoot,
                  ),
                  MyButton(
                    icon: Icons.arrow_forward,
                    function: moveRight,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
