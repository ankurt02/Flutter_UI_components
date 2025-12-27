import 'package:card_3d_image/card.dart';
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
      home: ArchetypeDeck(),
    );
  }
}


class ArchetypeDeck extends StatelessWidget {
  const ArchetypeDeck({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      TiltArchetypeCard(
        data: ArchetypeCardData(
          title: "The Engineer",
          subtitle: "Lorem ipsum dolor sit amet",
          year: "2025",
          imagePath:
              "assets/images/laptop3Dblack-removebg-preview.png", // use image with no background
        ),
      ),
      TiltArchetypeCard(
        data: ArchetypeCardData(
          title: "The Engineer",
          subtitle: "Lorem ipsum dolor sit amet",
          year: "2025",
          imagePath:
              "assets/images/laptop3Dblack-removebg-preview.png", // use image with no background
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(child: Wrap(spacing: 40, runSpacing: 40, children: cards)),
    );
  }
}
