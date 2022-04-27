import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class WidgetViewButton extends StatelessWidget {
  String text;
  IconData icon;
  var onTap;

  WidgetViewButton(
      {Key? key, required this.text, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Icon(
              icon,
              color: globals.white1,
            ),
            const SizedBox(width: 25),
            Text(
              text,
              style: TextStyle(
                  fontSize: 18,
                  color: globals.white1,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
