import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/taskSquare.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';

class MiddleView extends StatelessWidget {
  List<TaskSquare> childrenTaskList;
  bool isLoadingTasks;

  MiddleView({
    Key? key,
    required this.childrenTaskList,
    required this.isLoadingTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Tasks',
                style: TextStyle(
                    fontSize: 32,
                    color: globals.whiteBlue,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              // Row(
              //   children: [
              //     const SizedBox(height: 25),
              //     Expanded(
              //       child: ClipRRect(
              //         borderRadius:
              //             const BorderRadius.all(Radius.circular(12.0)),
              //         child: Container(
              //           margin: const EdgeInsets.all(8.0),
              //           decoration: const BoxDecoration(
              //             borderRadius: BorderRadius.all(Radius.circular(12.0)),
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: childrenProjectList,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              isLoadingTasks == false
                  ? Expanded(
                      child: ScrollConfiguration(
                        behavior: MyCustomScrollBehavior()
                            .copyWith(scrollbars: false),
                        child: SingleChildScrollView(
                          controller: globals.controllerMiddlePage,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: childrenTaskList,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        height: 42.0,
                        width: 42.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: globals.logoColorPink,
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
            ],
          )),
    );
  }
}
