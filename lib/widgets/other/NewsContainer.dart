import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class NewsContainer extends StatelessWidget {
  String text;
  String date;
  double drawerRightSize;

  NewsContainer({
    Key? key,
    required this.text,
    required this.date,
    required this.drawerRightSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: drawerRightSize,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(4.0),
      constraints: const BoxConstraints(minHeight: 70),
      decoration: BoxDecoration(
        border: Border.all(color: globals.white1),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: globals.white2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 20,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    date,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 12,
                      color: globals.white1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
