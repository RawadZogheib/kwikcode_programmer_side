import 'package:flutter/material.dart';

class BidItem extends StatelessWidget {
  String bidName;

  BidItem({Key? key, required this.bidName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      margin: const EdgeInsets.all(4.0),
      color: Colors.red,
      child: Text(bidName),
    );
  }
}
