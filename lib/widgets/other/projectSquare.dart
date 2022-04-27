import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class ProjectSquare extends StatelessWidget {
  String name;
  String imgUrl;
  var onTap;

  ProjectSquare(
      {Key? key, required this.name, required this.imgUrl, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 100,
        width: 100,
        margin: const EdgeInsets.all(4.0),
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
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
