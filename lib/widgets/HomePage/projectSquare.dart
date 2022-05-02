import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class ProjectSquare extends StatefulWidget {
  String name;
  String imgUrl;
  bool isSelected;
  var onTap;

  ProjectSquare({
    Key? key,
    required this.name,
    required this.imgUrl,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ProjectSquare> createState() => _ProjectSquareState();
}

class _ProjectSquareState extends State<ProjectSquare> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => _onTap(),
      child: Container(
        height: 118,
        width: 150,
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: globals.darkBlue2,
          border: widget.isSelected == true
              ? Border.all(color: globals.logoColorPink).scale(4.0)
              : Border.all(color: globals.logoColorPink).scale(1.0),
          borderRadius: const BorderRadius.all(Radius.circular(14.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              child: Image.network(
                widget.imgUrl,
                height: 66,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _onTap() {
    setState(() {
      widget.isSelected = !widget.isSelected;
    });
    widget.onTap();
  }
}
