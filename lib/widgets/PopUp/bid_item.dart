import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class BidItem extends StatelessWidget {
  String bidName;
  int kwikPointsAmount;
  Color color;

  BidItem({
    Key? key,
    required this.bidName,
    required this.kwikPointsAmount,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(bidName),
          Text(kwikPointsAmount.toString())
        ],
      )),
    );
  }
}
