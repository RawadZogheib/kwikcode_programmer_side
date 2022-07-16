import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class RankItem extends StatelessWidget {
  int rank;
  String userName;
  String kwikPointsAmount;

  RankItem({
    Key? key,
    required this.rank,
    required this.userName,
    required this.kwikPointsAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 80),
            SizedBox(
              width: 40,
              child: Text(
                '#$rank',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: rank==1?globals.gold:rank==2?globals.silver:rank==3?globals.bronze:globals.white2,
                ),
              ),
            ),
            // const SizedBox(width: 0),
            SizedBox(
              width: 150,
              child: Text(
                userName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: globals.white2,
                ),
              ),
            ),
            const SizedBox(width: 37),
            SizedBox(height: 16, child: VerticalDivider(color: globals.white1, thickness: 3)),
            // const SizedBox(width: 95),
            SizedBox(
              width: 240,
              child: Text(
                kwikPointsAmount,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: globals.white2,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 500, child: Divider(color: globals.white1)),
      ],
    );
  }
}
