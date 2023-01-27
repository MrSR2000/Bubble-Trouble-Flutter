import 'package:bubble_trouble/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _options(
              alignX: 0.8,
              alignY: -0.25,
              text: 'Start',
              context: context,
              pageroute: HomePage(),
            ),
            _options(
              alignX: 0.8,
              alignY: 0,
              text: 'Settings',
              context: context,
              pageroute: MenuPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _options(
      {required double alignX,
      required double alignY,
      required String text,
      required context,
      required pageroute}) {
    return Container(
      alignment: Alignment(alignX, alignY),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () {
          print('start game');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => pageroute));
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 45, color: Colors.yellow),
        ),
      ),
    );
  }
}
