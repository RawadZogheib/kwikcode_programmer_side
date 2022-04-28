import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class TaskSquare extends StatelessWidget {
  String taskName;
  String description;
  String projectManager;
  String imgUrl;

  TaskSquare(
      {Key? key,
      required this.taskName,
      required this.description,
      required this.projectManager,
      required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        height: 300,
        width: 300,
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: globals.darkBlue2,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              taskName,
              style: TextStyle(
                  fontSize: 22,
                  color: globals.white2,
                  fontWeight: FontWeight.bold),
            ),
            Positioned(
              bottom: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Project Manager: ',
                    style: TextStyle(fontSize: 14, color: globals.white1),
                  ),
                  Text(
                    projectManager,
                    style: TextStyle(fontSize: 12, color: globals.white1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      back: Container(
        height: 300,
        width: 300,
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: globals.darkBlue2,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Task Description:',
              style: TextStyle(
                  fontSize: 18,
                  color: globals.white2,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              child: Text(
                description,
                style: TextStyle(fontSize: 16, color: globals.white1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
