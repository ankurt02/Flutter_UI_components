import 'package:flutter/cupertino.dart';

class CustomContainer extends StatefulWidget {
  final Color color;
  const CustomContainer({super.key, required this.color});

  @override
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(20)),
      width: size.width < 600 ? size.width * 0.7 : size.width * 0.5,
      height: size.width < 600 ? size.height * 0.25 : size.height * 0.3,
    );
  }
}
