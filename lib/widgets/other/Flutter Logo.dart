import 'package:flutter/material.dart';

class MyFlutterLogo extends StatelessWidget {
  final Color color;
  final double? size;

  const MyFlutterLogo({
    Key? key,
    required this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      child: FlutterLogo(size: size),
    );
  }
}