import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ArchetypeCardData {
  final String title;
  final String subtitle;
  final String year;
  final String imagePath;

  ArchetypeCardData({
    required this.title,
    required this.subtitle,
    required this.year,
    required this.imagePath,
  });
}

class TiltArchetypeCard extends StatefulWidget {
  final ArchetypeCardData data;
  final bool enableShader;

  const TiltArchetypeCard({
    super.key,
    required this.data,
    this.enableShader = true,
  });

  @override
  State<TiltArchetypeCard> createState() => _TiltArchetypeCardState();
}

class _TiltArchetypeCardState extends State<TiltArchetypeCard>
    with SingleTickerProviderStateMixin {
  double tiltX = 0;
  double tiltY = 0;
  double parallaxX = 0;
  double parallaxY = 0;

  late AnimationController logoController;

  ui.FragmentShader? shader;

  @override
  void initState() {
    super.initState();

    logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat();

    // accelerometer for mobile tilt
    accelerometerEvents.listen((event) {
      setState(() {
        tiltX = (event.y / 10) * 0.4;
        tiltY = (event.x / 10) * 0.4;

        parallaxX = event.x * 2;
        parallaxY = event.y * 2;
      });
    });

    _loadShader();
  }

  Future<void> _loadShader() async {
    try {
      final program = await ui.FragmentProgram.fromAsset('shaders/holo.frag');
      shader = program.fragmentShader();
      setState(() {});
    } catch (_) {
      // fallback if shader missing
      shader = null;
    }
  }

  void updateHover(Offset p, Size size) {
    final dx = (p.dx - size.width / 2) / (size.width / 2);
    final dy = (p.dy - size.height / 2) / (size.height / 2);

    setState(() {
      tiltY = dx * 0.5;
      tiltX = -dy * 0.5;

      parallaxX = dx * 20;
      parallaxY = dy * 20;
    });
  }

  void resetHover() {
    setState(() {
      tiltX = 0;
      tiltY = 0;
      parallaxX = 0;
      parallaxY = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    const width = 340.0;
    const height = 520.0;

    return MouseRegion(
      onHover: (e) => updateHover(e.localPosition, const Size(width, height)),
      onExit: (_) => resetHover(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(tiltX)
            ..rotateY(tiltY),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            padding: const EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Column(
                children: [
                  // 🎨 HOLOGRAM IMAGE PANEL
                  Expanded(
                    child: Stack(
                      children: [
                        //  gradient base
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffFF9A9E),
                                Color(0xffFECFEF),
                                Color(0xffA1C4FD),
                                Color(0xffC2E9FB),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),

                        // 🌀 floating repeating logos
                        AnimatedBuilder(
                          animation: logoController,
                          builder: (_, __) {
                            final t = logoController.value;
                            return CustomPaint(
                              painter: LogoPatternPainter(t),
                              size: const Size(double.infinity, double.infinity),
                            );
                          },
                        ),

                        // 🧭 OPTIONAL GPU shader hologram
                        if (shader != null && widget.enableShader)
                          Positioned.fill(
                            child: CustomPaint(
                              painter: ShaderPainter(shader!),
                            ),
                          ),

                        // frosted layer
                        Positioned.fill(
                          child: Container(
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),

                        // text and hero image
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Text(
                                  "Your Archetype",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Text(
                                  widget.data.year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Transform.translate(
                                  offset:
                                      Offset(-parallaxX * .8, -parallaxY * .8),
                                  child: Image.asset(
                                    widget.data.imagePath,
                                    height: 190,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ⬜ WHITE TEXT PANEL
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 22),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.data.subtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// floating logo painter
class LogoPatternPainter extends CustomPainter {
  final double t;
  LogoPatternPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    const icon = Icons.settings; // use your symbol
    final tp = TextPainter(textDirection: TextDirection.ltr);

    for (double x = -50; x < size.width + 50; x += 90) {
      for (double y = -50; y < size.height + 50; y += 90) {
        tp.text = TextSpan(
          text: "⚙️",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white.withOpacity(0.25),
          ),
        );
        tp.layout();
        tp.paint(canvas, Offset(x + 20 * sin(t * 2 * pi), y + 20 * cos(t * 2 * pi)));
      }
    }
  }

  @override
  bool shouldRepaint(covariant LogoPatternPainter oldDelegate) => true;
}

// shader painter wrapper
class ShaderPainter extends CustomPainter {
  final ui.FragmentShader shader;

  ShaderPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    final paint = Paint()..shader = shader;

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
