import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class ProjectSquare extends StatelessWidget {
  String name;
  String imgUrl;

  ProjectSquare({Key? key, required this.name, required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: globals.darkBlue2,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            child: Image.network(
              imgUrl,
              height: 100,
              width: 100,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
