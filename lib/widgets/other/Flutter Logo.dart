import 'package:flutter/material.dart';

class StylizedFlutterLogo extends StatelessWidget {
  final ColorFilter colorFilter;
  final double? size;

  StylizedFlutterLogo({
    Key? key,
    required this.colorFilter,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: colorFilter,
      child: FlutterLogo(size: size),
    );
  }
}

class MyFlutterLogo extends StatelessWidget {
  final double size;
  MyFlutterLogo({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StylizedFlutterLogo(
      size: size,
      colorFilter: const ColorFilter.matrix(<double>[
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ]),
    );
  }
}
