import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';
import 'package:kwikcode_programmer_side/widgets/toolTip/toolTip.dart';

class TaskSquare extends StatefulWidget {
  String taskName;
  String projectManager;
  String description;
  int timeLeft;
  List<Widget> iconList;
  int status;
  var removeTask;
  var onBidTap;

  TaskSquare({
    Key? key,
    required this.taskName,
    required this.projectManager,
    required this.description,
    required this.timeLeft,
    required this.iconList,
    required this.status,
    required this.removeTask,
    required this.onBidTap,
  }) : super(key: key);

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
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return FlipCard(
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        height: 300,
        width: 300,
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: globals.darkBlue2,
          border: Border.all(color: globals.logoColorBlue).scale(1.0),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              widget.taskName,
              style: TextStyle(
                  fontSize: 22,
                  color: globals.whiteBlue,
                  fontWeight: FontWeight.bold),
            ),
            Positioned(
              bottom: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 18,
                    child: Text(
                      'Project Manager: ',
                      style: TextStyle(fontSize: 12, color: globals.white1),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                    child: Text(
                      widget.projectManager,
                      style: TextStyle(
                          fontSize: 14,
                          color: globals.white2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          widget.status == 3 || widget.status == 5
                              ? Icons.warning
                              : NewIcons.circle,
                          size: 18.0,
                          color: widget.status == 0 || widget.status == 5
                              ? Colors.red
                              : widget.status == 1 || widget.status == 3
                                  ? Colors.orange
                                  : widget.status == 2
                                      ? Colors.blue
                                      : widget.status == 4
                                          ? Colors.green
                                          : Colors.transparent.withOpacity(0.1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  widget.status == 0 ||
                          widget.status == 1 ||
                          widget.status == 2 ||
                          widget.status == 3
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: globals.white2,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _printDuration(
                                  Duration(seconds: widget.timeLeft)),
                              style: TextStyle(
                                  fontSize: 12, color: globals.white2),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  widget.status == 0 || widget.status == 1 || widget.status == 2
                      ? const SizedBox(height: 8.0)
                      : const SizedBox(),
                  widget.status == 0 || widget.status == 1
                      ? InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () => _goToBid(),
                          child: Container(
                            height: 30,
                            width: 75,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: globals.white2,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: Text(
                              'Bid',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: globals.darkBlue2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : widget.status == 2
                          ? InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: () => _contactAdmin(),
                              child: Container(
                                height: 30,
                                width: 75,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: globals.white2,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                                child: Text(
                                  'Chat Admin',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: globals.darkBlue2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : const SizedBox(),
                ],
              ),
            ),
            Positioned(
              left: 0,
              child: Container(
                height: 300,
                width: 70,
                padding: const EdgeInsets.all(8.0),
                // decoration: BoxDecoration(
                //   color: globals.darkBlue2,
                //   borderRadius:
                //   const BorderRadius.all(Radius.circular(4.0)),
                // ),
                child: ScrollConfiguration(
                  behavior:
                      MyCustomScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.iconList,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 15,
              right: 15,
              child: TargetWidget(),
            ),
          ],
        ),
      ),
      back: Container(
        height: 300,
        width: 300,
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: globals.darkBlue1,
          border: Border.all(color: globals.logoColorBlue).scale(1.0),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 45.0),
            Text(
              'Task Description:',
              style: TextStyle(
                  fontSize: 18,
                  color: globals.white2,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: ScrollConfiguration(
                    behavior:
                        MyCustomScrollBehavior().copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Text(
                        widget.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: globals.white1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _timeLeftChrono() {
    if (widget.status == 1 || widget.status == 2) {
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
    } else {
      print(widget.key);
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  _contactAdmin() {
    print('Contact Admin.');
  }

  _goToBid() {
    widget.onBidTap(widget.key);
    print('Go to Bid');
  }
}
