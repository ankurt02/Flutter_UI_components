// import 'package:flutter/material.dart';

// void main() => runApp(const MaterialApp(home: HolographicCardPage()));

// class HolographicCardPage extends StatelessWidget {
//   const HolographicCardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A1A), // Darker bg makes the card pop
//       body: Center(
//         child: InteractiveHoloCard(),
//       ),
//     );
//   }
// }

// class InteractiveHoloCard extends StatefulWidget {
//   @override
//   _InteractiveHoloCardState createState() => _InteractiveHoloCardState();
// }

// class _InteractiveHoloCardState extends State<InteractiveHoloCard> {
//   // Use Offset to track position for both rotation and shimmer
//   Offset _mousePos = Offset.zero;
//   bool _isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() {
//         _isHovered = false;
//         _mousePos = Offset.zero;
//       }),
//       onHover: (details) {
//         // Calculate normalized coordinates (-1 to 1)
//         final renderBox = context.findRenderObject() as RenderBox;
//         final size = renderBox.size;
//         final localPos = details.localPosition;
        
//         setState(() {
//           _mousePos = Offset(
//             (localPos.dx / size.width) * 2 - 1,
//             (localPos.dy / size.height) * 2 - 1,
//           );
//         });
//       },
//       // TweenAnimationBuilder provides much smoother interpolation than AnimatedContainer
//       child: TweenAnimationBuilder<Offset>(
//         tween: Tween(begin: Offset.zero, end: _isHovered ? _mousePos : Offset.zero),
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeOutCubic,
//         builder: (context, value, child) {
//           return Transform(
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.0015) // Perspective depth
//               ..rotateX(-value.dy * 0.3) // Tilt on X axis
//               ..rotateY(value.dx * 0.3), // Tilt on Y axis
//             alignment: FractionalOffset.center,
//             child: _buildCardBody(value),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCardBody(Offset value) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//       color: Colors.white,
//         // border: Border.all(
//         //   color: Colors.pink,
//         //   width: 2
//         // ),
//         borderRadius: BorderRadius.circular(24)
//       ),
//       child: Container(
//         width: 300,
//         height: 420,
//         decoration: BoxDecoration(
//           // border: Border.all(
//           //   color: Colors.yellow,
//           //   width: 2
//           // ),
//           borderRadius: BorderRadius.circular(20),
//           // boxShadow: [
//           //   BoxShadow(
//           //     color: Colors.black.withOpacity(0.5),
//           //     blurRadius: 30,
//           //     offset: Offset(value.dx * 10, value.dy * 10), // Shadow follows tilt
//           //   )
//           // ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Stack(
//             children: [
//               _buildBackground(),
//               _buildHoloIcons(value),
//               _buildMainContent(),
//               _buildIridescentShimmer(value),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBackground() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFFFDCB82), Color(0xFFE1A7F4), Color(0xFF82D9FD)],
//         ),
//       ),
//     );
//   }

//   // Widget _buildHoloIcons(Offset value) {
//   //   return Opacity(
//   //     opacity: 0.15,
//   //     // Slight parallax effect: icons move opposite to tilt
//   //     child: Transform.translate(
//   //       offset: Offset(value.dx * -10, value.dy * -10),
//   //       child: GridView.builder(
//   //         physics: const NeverScrollableScrollPhysics(),
//   //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
//   //         itemBuilder: (context, index) => const Icon(Icons.blur_circular, size: 30, color: Colors.white),
//   //       ),
//   //     ),
//   //   );
//   // }
//   Widget _buildHoloPatterns() {
//   return ShaderMask(
//     shaderCallback: (bounds) {
//       return LinearGradient(
//         begin: Alignment(_lightPos.dx - 1, _lightPos.dy - 1),
//         end: Alignment(_lightPos.dx, _lightPos.dy),
//         colors: [Colors.white24, Colors.cyanAccent, Colors.white24],
//       ).createShader(bounds);
//     },
//     blendMode: BlendMode.srcIn,
//     child: Opacity(
//       opacity: 0.3,
//       child: GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 6,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//         ),
//         itemBuilder: (context, index) => const Icon(Icons.auto_awesome, size: 24),
//       ),
//     ),
//   );
// }

//   Widget _buildMainContent() {
//     return Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Your Archetype", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
//               Text("2025", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
//             ],
//           ),
//         ),
//         const Spacer(),
//         // Character Image Placeholder
//         const Icon(Icons.auto_awesome, size: 120, color: Colors.white),
//         const Spacer(),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(20),
//           color: Colors.white,
//           child: const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("The Engineer", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black87)),
//               SizedBox(height: 4),
//               Text("19.1% of users share this archetype", style: TextStyle(color: Colors.grey, fontSize: 13)),
//             ],
//           ),
//         )
//       ],
//     );
//   }


// Widget _buildShimmerOverlay() {
//   return IgnorePointer(
//     child: AnimatedContainer(
//       duration: const Duration(milliseconds: 150),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         // This gradient creates the rainbow "oil-slick" effect
//         gradient: LinearGradient(
//           begin: Alignment(
//             (_lightPos.dx * 2 - 1) * -1.5, // Moving opposite to mouse
//             (_lightPos.dy * 2 - 1) * -1.5,
//           ),
//           end: Alignment(
//             (_lightPos.dx * 2 - 1) * 1.5,
//             (_lightPos.dy * 2 - 1) * 1.5,
//           ),
//           colors: [
//             Colors.white.withOpacity(0.0),
//             Colors.cyan.withOpacity(0.2),
//             Colors.magenta.withOpacity(0.2),
//             // Colors.yellow.withOpacity(0.2),
//             Colors.white.withOpacity(0.4), // The "Hot Spot" of light
//             Colors.blue.withOpacity(0.2),
//             Colors.white.withOpacity(0.0),
//           ],
//           stops: const [0.0, 0.2, 0.4, 0.5, 0.6, 0.8, 1.0],
//         ),
//       ),
//       // BlendMode 'screen' or 'colorDodge' makes it look like light reflection
//       foregroundDecoration: BoxDecoration(
//         backgroundBlendMode: BlendMode.screen,
//       ),
//     ),
//   );
// }
//   // Widget _buildIridescentShimmer(Offset value) {
//   //   return IgnorePointer(
//   //     child: Container(
//   //       decoration: BoxDecoration(
//   //         // Rainbow spectral gradient
//   //         gradient: LinearGradient(
//   //           begin: Alignment(value.dx, value.dy),
//   //           end: Alignment(-value.dx, -value.dy),
//   //           colors: [
//   //             Colors.white.withOpacity(0.0),
//   //             Colors.cyanAccent.withOpacity(0.15),
//   //             // Colors.magentaAccent.withOpacity(0.15),
//   //             Colors.yellowAccent.withOpacity(0.15),
//   //             Colors.white.withOpacity(0.4), // The highlight
//   //             Colors.white.withOpacity(0.0),
//   //           ],
//   //           stops: const [0.0, 0.3, 0.45, 0.6, 0.7, 1.0],
//   //         ),
//   //         backgroundBlendMode: BlendMode.screen,
//   //       ),
//   //     ),
//   //   );
//   // }
// }


/// SECOND SCREEN 

// import 'package:flutter/material.dart';

// void main() => runApp(const MaterialApp(home: HolographicCardPage()));

// class HolographicCardPage extends StatelessWidget {
//   const HolographicCardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A1A),
//       body: Center(
//         child: InteractiveHoloCard(),
//       ),
//     );
//   }
// }

// class InteractiveHoloCard extends StatefulWidget {
//   @override
//   _InteractiveHoloCardState createState() => _InteractiveHoloCardState();
// }

// class _InteractiveHoloCardState extends State<InteractiveHoloCard> {
//   Offset _mousePos = Offset.zero;
//   bool _isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() {
//         _isHovered = false;
//         _mousePos = Offset.zero;
//       }),
//       onHover: (details) {
//         final renderBox = context.findRenderObject() as RenderBox;
//         final size = renderBox.size;
//         final localPos = details.localPosition;
        
//         setState(() {
//           _mousePos = Offset(
//             (localPos.dx / size.width) * 2 - 1,
//             (localPos.dy / size.height) * 2 - 1,
//           );
//         });
//       },
//       child: TweenAnimationBuilder<Offset>(
//         tween: Tween(begin: Offset.zero, end: _isHovered ? _mousePos : Offset.zero),
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeOutCubic,
//         builder: (context, value, child) {
//           return Transform(
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.0015)
//               ..rotateX(-value.dy * 0.3)
//               ..rotateY(value.dx * 0.3),
//             alignment: FractionalOffset.center,
//             child: _buildCardBody(value),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCardBody(Offset value) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.5),
//             blurRadius: 30,
//             offset: Offset(value.dx * 10, value.dy * 10),
//           )
//         ],
//       ),
//       child: Container(
//         width: 300,
//         height: 420,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Stack(
//             children: [
//               _buildBackground(),
//               _buildHoloPatterns(value), // Pass 'value' here
//               _buildMainContent(),
//               _buildIridescentShimmer(value), // Pass 'value' here
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBackground() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFFFDCB82), Color(0xFFE1A7F4), Color(0xFF82D9FD)],
//         ),
//       ),
//     );
//   }

//   Widget _buildHoloPatterns(Offset value) {
//     return ShaderMask(
//       shaderCallback: (bounds) {
//         return LinearGradient(
//           // Uses 'value' for the holographic shift
//           begin: Alignment(value.dx - 0.5, value.dy - 0.5),
//           end: Alignment(value.dx + 0.5, value.dy + 0.5),
//           colors: const [Colors.white24, Colors.cyanAccent, Colors.white24],
//         ).createShader(bounds);
//       },
//       blendMode: BlendMode.srcIn,
//       child: Opacity(
//         opacity: 0.3,
//         child: GridView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 6,
//             mainAxisSpacing: 10,
//             crossAxisSpacing: 10,
//           ),
//           itemBuilder: (context, index) => const Icon(Icons.auto_awesome, size: 24),
//         ),
//       ),
//     );
//   }

//   Widget _buildMainContent() {
//     return Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Your Archetype", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
//               Text("2025", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
//             ],
//           ),
//         ),
//         const Spacer(),
//         const Icon(Icons.adb, size: 120, color: Colors.white),
//         const Spacer(),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(20),
//           color: Colors.white,
//           child: const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("The Engineer", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black87)),
//               SizedBox(height: 4),
//               Text("19.1% of users share this archetype", style: TextStyle(color: Colors.grey, fontSize: 13)),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildIridescentShimmer(Offset value) {
//     return IgnorePointer(
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//             begin: Alignment(value.dx * -1.5, value.dy * -1.5),
//             end: Alignment(value.dx * 1.5, value.dy * 1.5),
//             colors: [
//               Colors.white.withOpacity(0.0),
//               Colors.cyan.withOpacity(0.2),
//               // Colors.magenta.withOpacity(0.2),
//               Colors.white.withOpacity(0.4),
//               Colors.blue.withOpacity(0.2),
//               Colors.white.withOpacity(0.0),
//             ],
//             stops: const [0.0, 0.2, 0.4, 0.5, 0.7, 1.0],
//           ),
//         ),
//         // foregroundDecoration: const BoxDecoration(
//         //   backgroundBlendMode: BlendMode.screen,
//         // ),
//       ),
//     );
//   }
// }



/// THIRD SCREEN 
/// 
// import 'package:flutter/material.dart';

// void main() => runApp(const MaterialApp(home: HolographicCardPage()));

// class HolographicCardPage extends StatelessWidget {
//   const HolographicCardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A1A),
//       body: Center(
//         child: InteractiveHoloCard(),
//       ),
//     );
//   }
// }

// class InteractiveHoloCard extends StatefulWidget {
//   @override
//   _InteractiveHoloCardState createState() => _InteractiveHoloCardState();
// }

// class _InteractiveHoloCardState extends State<InteractiveHoloCard> {
//   Offset _mousePos = Offset.zero;
//   bool _isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() {
//         _isHovered = false;
//         _mousePos = Offset.zero;
//       }),
//       onHover: (details) {
//         final renderBox = context.findRenderObject() as RenderBox;
//         final size = renderBox.size;
//         final localPos = details.localPosition;
        
//         setState(() {
//           _mousePos = Offset(
//             (localPos.dx / size.width) * 2 - 1,
//             (localPos.dy / size.height) * 2 - 1,
//           );
//         });
//       },
//       child: TweenAnimationBuilder<Offset>(
//         tween: Tween(begin: Offset.zero, end: _isHovered ? _mousePos : Offset.zero),
//         duration: const Duration(milliseconds: 250),
//         curve: Curves.easeOutCubic,
//         builder: (context, value, child) {
//           return Transform(
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.0012) // Subtle perspective
//               ..rotateX(-value.dy * 0.25)
//               ..rotateY(value.dx * 0.25),
//             alignment: FractionalOffset.center,
//             child: _buildCardBody(value),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCardBody(Offset value) {
//     return Container(
//       padding: const EdgeInsets.all(10), // The white border thickness
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.4),
//             blurRadius: 25,
//             offset: Offset(value.dx * 15, value.dy * 15),
//           )
//         ],
//       ),
//       child: Container(
//         width: 320,
//         height: 450,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Stack(
//             children: [
//               _buildBackground(),
//               // Larger Hologram Patterns
//               _buildHoloPatterns(value), 
//               _buildMainContent(),
//               _buildIridescentShimmer(value),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBackground() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFFFDCB82), Color(0xFFE1A7F4), Color(0xFF82D9FD)],
//         ),
//       ),
//     );
//   }

//   Widget _buildHoloPatterns(Offset value) {
//     return ShaderMask(
//       shaderCallback: (bounds) {
//         return LinearGradient(
//           begin: Alignment(value.dx - 1, value.dy - 1),
//           end: Alignment(value.dx + 1, value.dy + 1),
//           colors: const [Colors.white10, Colors.cyanAccent, Colors.white10],
//           stops: [0.0, 0.5, 1.0],
//         ).createShader(bounds);
//       },
//       blendMode: BlendMode.srcIn,
//       child: Opacity(
//         opacity: 0.25,
//         child: GridView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(10),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 4, // Fewer columns = Larger icons
//             mainAxisSpacing: 25,
//             crossAxisSpacing: 25,
//           ),
//           itemBuilder: (context, index) => const Icon(
//             Icons.blur_circular, // Using the design from previous version
//             size: 45, // Much larger icon size
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMainContent() {
//     return Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Your Archetype", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
//               Text("2025", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
//             ],
//           ),
//         ),
//         const Spacer(),
//         // The main character icon/image
//         const Icon(Icons.adb, size: 140, color: Colors.white),
//         const Spacer(),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(24),
//           color: Colors.white,
//           child: const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("The Engineer", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black87)),
//               SizedBox(height: 6),
//               Text("19.1% of users share this archetype", style: TextStyle(color: Colors.grey, fontSize: 14)),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildIridescentShimmer(Offset value) {
//     return IgnorePointer(
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//             begin: Alignment(value.dx * -2, value.dy * -2),
//             end: Alignment(value.dx * 2, value.dy * 2),
//             colors: [
//               Colors.white.withOpacity(0.0),
//               Colors.cyan.withOpacity(0.1),
//               // Colors.magenta.withOpacity(0.1),
//               Colors.white.withOpacity(0.45), // Bright reflection
//               Colors.white.withOpacity(0.0),
//             ],
//             stops: const [0.0, 0.3, 0.45, 0.55, 1.0],
//           ),
//         ),
//         // foregroundDecoration: const BoxDecoration(
//         //   backgroundBlendMode: BlendMode.screen,
//         // ),
//       ),
//     );
//   }
// }



/// FOUTH SCREEN
/// 

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MaterialApp(home: HolographicCardPage()));

class HolographicCardPage extends StatelessWidget {
  const HolographicCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: InteractiveHoloCard(),
      ),
    );
  }
}

class InteractiveHoloCard extends StatefulWidget {
  @override
  _InteractiveHoloCardState createState() => _InteractiveHoloCardState();
}

class _InteractiveHoloCardState extends State<InteractiveHoloCard> {
  Offset _mousePos = Offset.zero;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _mousePos = Offset.zero;
      }),
      onHover: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final size = renderBox.size;
        final localPos = details.localPosition;
        
        setState(() {
          _mousePos = Offset(
            (localPos.dx / size.width) * 2 - 1,
            (localPos.dy / size.height) * 2 - 1,
          );
        });
      },
      child: TweenAnimationBuilder<Offset>(
        tween: Tween(begin: Offset.zero, end: _isHovered ? _mousePos : Offset.zero),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateX(-value.dy * 0.25)
              ..rotateY(value.dx * 0.25),
            alignment: FractionalOffset.center,
            child: _buildCardBody(value),
          );
        },
      ),
    );
  }

  Widget _buildCardBody(Offset value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 30,
            offset: Offset(value.dx * 15, value.dy * 15),
          )
        ],
      ),
      child: Container(
        width: 320,
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              _buildBackground(),
              _buildHoloPatterns(value), 
              _buildMainContent(),
              _buildIridescentShimmer(value),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFDCB82), Color(0xFFE1A7F4), Color(0xFF82D9FD)],
        ),
      ),
    );
  }

  // Widget _buildHoloPatterns(Offset value) {
  //   return ShaderMask(
  //     shaderCallback: (bounds) {
  //       return LinearGradient(
  //         begin: Alignment(value.dx - 1, value.dy - 1),
  //         end: Alignment(value.dx + 1, value.dy + 1),
  //         colors: const [Colors.white10, Color.fromARGB(255, 24, 163, 255), Colors.white10],
  //         stops: [0.0, 0.5, 1.0],
  //       ).createShader(bounds);
  //     },
  //     blendMode: BlendMode.srcIn,
  //     child: Opacity(
  //       opacity: 0.2,
  //       child: GridView.builder(
  //         physics: const NeverScrollableScrollPhysics(),
  //         padding: const EdgeInsets.all(15),
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 4,
  //           mainAxisSpacing: 30,
  //           crossAxisSpacing: 30,
  //         ),
  //         // Using a Pentagon/Hexagon like shape for the hologram
  //         itemBuilder: (context, index) => Transform.rotate(
  //           angle: math.pi / 4,
  //           child: const Icon(Icons.interests_outlined, size: 40),
  //         ),
  //       ),
  //     ),
  //   );
  // }



// Widget _buildHoloPatterns(Offset value) {
//   // 1. Calculate how much the card is tilted (0.0 to ~0.6)
//   double tiltAmount = (value.dx.abs() + value.dy.abs());
  
//   // 2. Visibility Threshold: Only start showing icons after 15% tilt
//   // This ensures they stay hidden when the card is "flat" or just slightly moving.
//   double visibilityFactor = ((tiltAmount - 0.15) * 2.5).clamp(0.0, 1.0);

//   return Transform.translate(
//     // PARALLAX: Icons move opposite to tilt to create depth
//     offset: Offset(value.dx * -10, value.dy * -10),
//     child: Opacity(
//       opacity: visibilityFactor, // Becomes visible only when tilted
//       child: ShaderMask(
//         shaderCallback: (bounds) {
//           return LinearGradient(
//             // The light sweeps across based on tilt
//             begin: Alignment(value.dx * -4 - 0.5, value.dy * -4 - 0.5),
//             end: Alignment(value.dx * -4 + 0.5, value.dy * -4 + 0.5),
//             colors: [
//               Colors.transparent,
//               const Color(0xFF18A3FF).withOpacity(0.6),
//               Colors.white.withOpacity(0.9), // The sharp highlight
//               const Color(0xFF18A3FF).withOpacity(0.6),
//               Colors.transparent,
//             ],
//             stops: const [0.0, 0.4, 0.5, 0.6, 1.0],
//           ).createShader(bounds);
//         },
//         blendMode: BlendMode.srcIn,
//         child: GridView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(15),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 4,
//             mainAxisSpacing: 30,
//             crossAxisSpacing: 30,
//           ),
//           itemBuilder: (context, index) => Transform.rotate(
//             angle: math.pi / 4,
//             child: const Icon(
//               Icons.interests_outlined, 
//               size: 40,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }


Widget _buildHoloPatterns(Offset value) {
  // 1. Calculate tilt intensity
  double tiltAmount = (value.dx.abs() + value.dy.abs());
  
  // 2. Visibility Threshold: Completely invisible until 10% tilt
  // Increases quickly thereafter to simulate catching the light
  double visibilityFactor = ((tiltAmount - 0.1) * 3.0).clamp(0.0, 1.0);

  return Transform.translate(
    // Deep Parallax: Icons shift slightly to look like they are under the surface
    offset: Offset(value.dx * -12, value.dy * -12),
    child: Opacity(
      opacity: visibilityFactor, 
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            // High-speed glint: The highlight sweeps 5x faster than tilt
            begin: Alignment(value.dx * -5 - 0.5, value.dy * -5 - 0.5),
            end: Alignment(value.dx * -5 + 0.5, value.dy * -5 + 0.5),
            colors: [
              Colors.transparent,
              const Color(0xFF18A3FF).withOpacity(0.5),
              Colors.white.withOpacity(0.95), // The "Glint" point
              const Color(0xFF18A3FF).withOpacity(0.5),
              Colors.transparent,
            ],
            stops: const [0.0, 0.45, 0.5, 0.55, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcIn,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,      // More icons per row (was 4)
            mainAxisSpacing: 15,    // Tighter spacing
            crossAxisSpacing: 15,
          ),
          itemBuilder: (context, index) => Transform.rotate(
            angle: math.pi / 4,
            child: const Icon(
              Icons.interests_outlined, 
              size: 22,             // Smaller size for a dense look (was 40)
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}

  Widget _buildMainContent() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Your Archetype", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              Text("2025", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
        const Spacer(),
        // Restored the previous "Sparkle" shape from the design
        const Icon(Icons.auto_awesome, size: 140, color: Colors.white),
        const Spacer(),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          color: Colors.white,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("The Engineer", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black87)),
              SizedBox(height: 6),
              Text("19.1% of users share this archetype", style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildIridescentShimmer(Offset value) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment(value.dx * -2, value.dy * -2),
            end: Alignment(value.dx * 2, value.dy * 2),
            colors: [
              Colors.white.withOpacity(0.0),
              Colors.cyan.withOpacity(0.12),
              // Colors.purple.withOpacity(0.02),
              Colors.white.withOpacity(0.5), 
              Colors.white.withOpacity(0.0),
            ],
            stops: const [0.0, 0.3, 0.45, 0.55, 1.0],
          ),
        ),
        // foregroundDecoration: const BoxDecoration(
        //   backgroundBlendMode: BlendMode.screen,
        // ),
      ),
    );
  }
}