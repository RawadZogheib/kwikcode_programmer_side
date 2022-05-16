import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              bidName,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 110,
            child: Text(
              kwikPointsAmount.toString(),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 20),
        ],
      )),
    );
  }
}
