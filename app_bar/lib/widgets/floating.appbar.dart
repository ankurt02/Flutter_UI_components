// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:app_bar/theme/theme_notifier.dart';
import 'package:app_bar/widgets/appBar.labels.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class FloatingAppBar extends StatelessWidget {
  const FloatingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: size.width * 0.8,
          height: size.height * 0.075,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: Colors.grey.shade500.withOpacity(0.5), width: 2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/circle.png',
                    width: 36,
                    fit: BoxFit.contain,
                  ),
                  Gap(8),
                  Text(
                    "Logo",
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBarLabels(text: 'Home'),
                  Gap(16),
                  AppBarLabels(text: 'About'),
                  Gap(16),
                  AppBarLabels(text: 'Education'),
                  Gap(16),
                  AppBarLabels(text: 'Projects'),
                  Gap(16),
                  AppBarLabels(text: 'Contact Me'),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .toggleTheme();
                  },
                  icon: Icon(
                    Icons.wb_sunny_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
