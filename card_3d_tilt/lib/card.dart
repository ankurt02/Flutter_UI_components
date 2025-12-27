import 'dart:math';
import 'package:flutter/material.dart';

class WrappedCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;

  const WrappedCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  State<WrappedCard> createState() => _WrappedCardState();
}

class _WrappedCardState extends State<WrappedCard> {
  double targetTiltX = 0;
  double targetTiltY = 0;

  void updateTilt(Offset p, Size s) {
    final dx = (p.dx - s.width / 2) / (s.width / 2);
    final dy = (p.dy - s.height / 2) / (s.height / 2);

    setState(() {
      targetTiltX = (-dy * 0.35).clamp(-0.5, 0.5);
      targetTiltY = (dx * 0.35).clamp(-0.5, 0.5);
    });
  }

  void resetTilt() {
    setState(() {
      targetTiltX = 0;
      targetTiltY = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = min(MediaQuery.of(context).size.width * 0.28, 360.0);
    final height = width * 1.35;

    return MouseRegion(
      onHover: (e) => updateTilt(e.localPosition, Size(width, height)),
      onExit: (_) => resetTilt(),

      /// 🔥 TweenAnimationBuilder = no lag, super smooth
      child: TweenAnimationBuilder(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: Offset(targetTiltY, targetTiltX),
        ),
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          final tiltY = value.dx;
          final tiltX = value.dy;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(tiltX)
              ..rotateY(tiltY),
            child: child,
          );
        },

        /// actual card UI
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),

            /// 🌈 glow border
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Colors.cyan.withOpacity(0.25),
                blurRadius: 55,
                spreadRadius: -10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Stack(
              children: [
                /// background image
                Positioned.fill(
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),

                /// holographic shimmer
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.withOpacity(
                              (targetTiltX.abs() + targetTiltY.abs()) * 0.6),
                          Colors.transparent,
                          Colors.cyan.withOpacity(
                              (targetTiltX.abs() + targetTiltY.abs()) * 0.6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),

                /// glass layer
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.25),
                  ),
                ),

                /// text content
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 22,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your Archetype",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
