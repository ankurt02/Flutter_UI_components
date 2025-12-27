import 'package:app_bar/main.dart';
import 'package:flutter/material.dart';

class AppBarLabels extends StatelessWidget {
  final String text;
  final Widget? destination;

  const AppBarLabels({
    super.key,
    required this.text,
    this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(text, style: Theme.of(context).textTheme.labelMedium),
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => destination ?? Home(), // Default to Home screen
          ),
          (route) => false,
        );
      },
    );
  }
}