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
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => onTap(),
      child: Container(
        height: 100,
        width: 150,
        margin: const EdgeInsets.all(12.0),
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
                height: 66,
                width: 150,
                fit: BoxFit.cover,
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
