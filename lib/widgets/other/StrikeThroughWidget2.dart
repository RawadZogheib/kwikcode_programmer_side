import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class StrikeThroughWidget2 extends StatelessWidget {
  Color color;
  final Widget _child;

  StrikeThroughWidget2({Key? key, required this.color, required Widget child})
      : _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: _child),
        //Center(child: Image.asset('Assets/HomePage/graphics/strikethrough2.png',width: 40,)),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 3),
              Container(
                height: 2,
                width: 32,
                color: color,
              ),
              const SizedBox(height: 2),
              Container(
                height: 2,
                width: 32,
                color: color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
