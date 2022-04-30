import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class TaskSquare extends StatefulWidget {
  String taskName;
  String projectManager;
  String description;
  int timeLeft;

  var removeTask;

  TaskSquare(
      {Key? key,
      required this.taskName,
      required this.projectManager,
      required this.description,
      required this.timeLeft,
      required this.removeTask})
      : super(key: key);

  @override
  State<TaskSquare> createState() => _TaskSquareState();
}

class _TaskSquareState extends State<TaskSquare> {
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    _timeLeftChrono();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

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
              widget.taskName,
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
                    widget.projectManager,
                    style: TextStyle(fontSize: 12, color: globals.white1),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: globals.white1,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _printDuration(Duration(seconds: widget.timeLeft)),
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
                widget.description,
                style: TextStyle(fontSize: 16, color: globals.white1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _timeLeftChrono() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      //  print("1sec gone!!");
      if (widget.timeLeft > 0) {
        if (mounted) {
          setState(() {
            widget.timeLeft--;
          });
        }
      } else {
        timer?.cancel();
        widget.removeTask(widget.key);
      }
    });
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
