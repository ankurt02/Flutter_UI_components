import 'package:card_3d_tilt/card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WrappedArchetypeDeck(),
    );
  }
}

class WrappedArchetypeDeck extends StatelessWidget {
  const WrappedArchetypeDeck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            WrappedCard(
              title: "The Engineer",
              subtitle: "You turned ideas into systems",
              image: "assets/images/yuta01.jpeg",
            ),
            SizedBox(width: 48),
            WrappedCard(
              title: "The Dreamer",
              subtitle: "You explored beyond code",
              image: "assets/images/anime01.jpg",
            ),
            SizedBox(width: 48),
            WrappedCard(
              title: "The Analyst",
              subtitle: "You saw patterns everywhere",
              image: "assets/images/yuta01.jpeg",
            ),
          ],
        ),
      ),
    );
  }
}
