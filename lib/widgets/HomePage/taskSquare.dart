import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';
import 'package:kwikcode_programmer_side/widgets/other/programmingItem.dart';
import 'package:kwikcode_programmer_side/widgets/toolTip/toolTip.dart';

class TaskSquare extends StatefulWidget {
  String taskId;
  String taskName;
  String projectManager;
  String projectName;
  String description;
  int timeLeft;
  List<TaskProgrammingItem> iconList;
  int status;
  bool animate;
  bool disableToolTip;
  bool isVisible;
  Function(String) removeTask;
  Function(String) onBidTap;

  TaskSquare({
    Key? key,
    required this.taskId,
    required this.taskName,
    required this.projectManager,
    required this.projectName,
    required this.description,
    required this.timeLeft,
    required this.iconList,
    required this.status,
    this.animate = false,
    this.disableToolTip = false,
    this.isVisible = true,
    required this.removeTask,
    required this.onBidTap,
  }) : super(key: key);

  @override
  State<TaskSquare> createState() => _TaskSquareState();
}

class _TaskSquareState extends State<TaskSquare> {
  Timer? _timer1;
  Timer? _timer2;
  bool _isClickedTooltip = false;
  bool _isLoadingBid = false;

  @override
  void initState() {
    // TODO: implement initState
    _timeLeftChrono();
    _animate();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer1?.cancel();
    _timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    // double _width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: widget.isVisible,
      child: FlipCard(
        fill: Fill.fillBack,
        direction: FlipDirection.HORIZONTAL,
        front: Container(
          height: 300,
          width: 300,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: globals.darkBlue2,
            border: Border.all(color: globals.logoColorBlue).scale(2.0),
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
                                            : Colors.transparent
                                                .withOpacity(0.1),
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
                    widget.status == 0 ||
                            widget.status == 1 ||
                            widget.status == 2
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                              ),
                              child: _isLoadingBid == false
                                  ? Row(
                                      children: [
                                        const SizedBox(
                                          height: 24.0,
                                          width: 24.0,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          'Bid',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: globals.darkBlue2,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Container(
                                          height: 24.0,
                                          width: 24.0,
                                          padding: const EdgeInsets.all(6.0),
                                          child: CircularProgressIndicator(
                                            color: globals.darkBlue2,
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          'Bid',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: globals.darkBlue2,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
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
              widget.disableToolTip == false
                  ? Positioned(
                      bottom: 15,
                      right: 15,
                      child: TargetWidget(taskId: widget.taskId),
                    )
                  : Positioned(
                      bottom: 15,
                      right: 15,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () => _onDisableToolTipTap(),
                            child: SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: Icon(
                                Icons.info_outline,
                                size: 20,
                                color: globals.white1,
                              ),
                            ),
                          ),
                          _isClickedTooltip == true
                              ? SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    color: globals.white1,
                                  ),
                                )
                              : const SizedBox(),
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
            color: globals.darkBlue1,
            border: Border.all(color: globals.logoColorBlue).scale(2.0),
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
      ),
    );
  }

  void _timeLeftChrono() {
    if (widget.status == 1 || widget.status == 2) {
      _timer1 = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        //  print("1sec gone!!");
        if (widget.timeLeft > 0) {
          if (mounted) {
            setState(() {
              widget.timeLeft--;
            });
          }
        } else {
          _timer1?.cancel();
          widget.removeTask(widget.taskId);
        }
      });
    } else {
      // if (widget.status == 0) {
      //   _timer1 = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      //     setState(() {});
      //   });
      // }
      //debugPrint(widget.key.toString());
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  _contactAdmin() {
    debugPrint('Contact Admin.');
  }

  _goToBid() async {
    if (globals.isLoadingBid == false) {
      globals.isLoadingBid = true;
      if(mounted){
        setState(() {
          _isLoadingBid = true;
        });
      }
      await widget.onBidTap(widget.taskId);
      if(mounted){
        setState(() {
          _isLoadingBid = false;
        });
      }
      debugPrint('Go to Bid');
    }
  }

  Future<void> _animate() async {
    if (widget.animate == true) {
      _timer2 = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          widget.status = (widget.status + 1) % 6;
        });
        debugPrint(widget.status.toString());
      });
    }
  }

  _onDisableToolTipTap() async {
    setState(() {
      _isClickedTooltip = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isClickedTooltip = false;
    });
  }
}
