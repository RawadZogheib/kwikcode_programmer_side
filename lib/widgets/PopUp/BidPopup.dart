import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/taskSquare.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';

class BidPopup extends StatelessWidget {
  TaskSquare childTaIsActive;
  var onBackTap;
  double _size = 35;

  BidPopup({
    Key? key,
    required this.childTaIsActive,
    required this.onBackTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height * 0.8,
      width: _width * 0.5,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: globals.darkBlue1,
        border: Border.all(color: globals.white1).scale(1.0),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Row(
            children: [
              const SizedBox(width: 20),
              InkWell(
                onTap: () => onBackTap(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: globals.white2,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () => _makeBid(),
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: globals.white2,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Text(
                    'Mak a bid ${(childTaIsActive.taskName).toString()}',
                    style: TextStyle(
                        fontSize: 14,
                        color: globals.darkBlue1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                        border: Border.all(color: globals.white2).scale(1.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Task Price: ',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: globals.white2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '1205',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: globals.white1,
                                ),
                              ),
                              Text(
                                ' (\$)',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: globals.white1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Task Time: ',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: globals.white2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '12',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: globals.white1,
                                ),
                              ),
                              Text(
                                ' (Days)',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: globals.white1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'My Point: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: globals.white2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '1205',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: globals.white1,
                                ),
                              ),
                              Text(
                                ' (KP)',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: globals.white1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: Container(
                        width: 220,
                        decoration: BoxDecoration(
                          border: Border.all(color: globals.white2).scale(1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            Text(
                              'Languages',
                              style: TextStyle(
                                fontSize: 18,
                                color: globals.white2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Expanded(
                              child: Container(
                                width: 210,
                                padding: const EdgeInsets.all(8.0),
                                child: ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior()
                                      .copyWith(scrollbars: false),
                                  child: SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: Wrap(
                                      spacing: 12.0,
                                      alignment: WrapAlignment.center,
                                      children: childTaIsActive.iconList,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: globals.darkBlue2,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _makeBid() {}
}
