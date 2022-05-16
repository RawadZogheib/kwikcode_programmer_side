import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/RankPage/RankItem.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class RankPage extends StatelessWidget {
  int myKwikPoints;

  RankPage({
    Key? key,
    required this.myKwikPoints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            /// Personal Rank
            Text(
              'Personal Rank',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: globals.white2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StrikeThroughWidget3(
                  color: globals.logoColorBlue,
                  child: Text(
                    'KP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: globals.logoColorBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  myKwikPoints.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: globals.white2,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: 'Bronze',
                      child: Image.asset(
                        'Assets/Rank/KwikCodeLogoBronze.png',
                        height: 54,
                        width: 54,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      height: 20,
                      width: 100,
                      child: LiquidLinearProgressIndicator(
                        value: myKwikPoints >= 1200
                            ? 2
                            : myKwikPoints.toDouble() / 1200,
                        valueColor:
                            AlwaysStoppedAnimation(globals.logoColorBlue),
                        backgroundColor: globals.whiteBlue,
                        borderColor: globals.logoColorBlue,
                        borderWidth: 1.0,
                        borderRadius: 12.0,
                        direction: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Tooltip(
                      message: 'Silver',
                      child: Image.asset(
                        'Assets/Rank/KwikCodeLogoSilver.png',
                        height: 54,
                        width: 54,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      height: 20,
                      width: 100,
                      child: LiquidLinearProgressIndicator(
                        value: myKwikPoints >= 1500
                            ? 2
                            : myKwikPoints < 1200
                                ? -1
                                : (myKwikPoints.toDouble() - 1200) / 300,
                        //(1500-1200)
                        valueColor:
                            AlwaysStoppedAnimation(globals.logoColorBlue),
                        backgroundColor: globals.whiteBlue,
                        borderColor: globals.logoColorBlue,
                        borderWidth: 1.0,
                        borderRadius: 12.0,
                        direction: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Tooltip(
                      message: 'Gold',
                      child: Image.asset(
                        'Assets/Rank/KwikCodeLogoGold.png',
                        height: 54,
                        width: 54,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      height: 20,
                      width: 100,
                      child: LiquidLinearProgressIndicator(
                        value: myKwikPoints >= 2000
                            ? 2
                            : myKwikPoints < 1500
                                ? -1
                                : (myKwikPoints.toDouble() - 1500) / 500,
                        //(2000-1500)
                        valueColor:
                            AlwaysStoppedAnimation(globals.logoColorBlue),
                        backgroundColor: globals.whiteBlue,
                        borderColor: globals.logoColorBlue,
                        borderWidth: 1.0,
                        borderRadius: 12.0,
                        direction: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Tooltip(
                      message: 'Platinum',
                      child: Image.asset(
                        'Assets/Rank/KwikCodeLogoPlatinum.png',
                        height: 54,
                        width: 54,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),

                /// 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 54,
                      child: Text(
                        '0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: globals.white2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 110),
                    SizedBox(
                      width: 54,
                      child: Text(
                        '1200',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: myKwikPoints >= 1200
                              ? globals.white2
                              : globals.white1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 110),
                    SizedBox(
                      width: 54,
                      child: Text(
                        '1500',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: myKwikPoints >= 1500
                              ? globals.white2
                              : globals.white1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 110),
                    SizedBox(
                      width: 54,
                      child: Text(
                        '2000',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: myKwikPoints >= 2000
                              ? globals.white2
                              : globals.white1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Divider(color: globals.white1),
            const SizedBox(height: 20),

            /// Global Rank
            Text(
              'Global Rank',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: globals.white2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'User Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: globals.white2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 60),
                    SizedBox(
                        height: 20,
                        child: VerticalDivider(color: globals.white1, thickness: 3)),
                    const SizedBox(width: 60),
                    Text(
                      'KwikPoints',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: globals.white2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: 500,
                    child: Divider(color: globals.white1, thickness: 2)),
                RankItem(rank: 1, userName: 'Micho', kwikPointsAmount: '1700'),
                RankItem(rank: 2, userName: 'Bilal', kwikPointsAmount: '1680'),
                RankItem(rank: 3, userName: 'Samir', kwikPointsAmount: '1590'),
                RankItem(rank: 4, userName: 'Rawad', kwikPointsAmount: '1420'),
                RankItem(rank: 5, userName: 'Arwa', kwikPointsAmount: '1210'),
                RankItem(rank: 6, userName: 'Rami', kwikPointsAmount: '1170'),


                RankItem(rank: 7, userName: 'Samir', kwikPointsAmount: '1590'),
                RankItem(rank: 8, userName: 'Rawad', kwikPointsAmount: '1420'),
                RankItem(rank: 9, userName: 'Arwa', kwikPointsAmount: '1210'),
                RankItem(rank: 10, userName: 'Rami', kwikPointsAmount: '1170'),
                RankItem(rank: 11, userName: 'Samir', kwikPointsAmount: '1590'),
                RankItem(rank: 12, userName: 'Rawad', kwikPointsAmount: '1420'),
                RankItem(rank: 13, userName: 'Arwa', kwikPointsAmount: '1210'),
                RankItem(rank: 14, userName: 'Rami', kwikPointsAmount: '1170'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StrikeThroughWidget3 extends StatelessWidget {
  Color color;
  final Widget _child;

  StrikeThroughWidget3({Key? key, required this.color, required Widget child})
      : _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(child: _child),
        //Center(child: Image.asset('Assets/HomePage/graphics/strikethrough2.png',width: 40,)),
        Center(
          child: Column(
            children: [
              const SizedBox(height: 3),
              Container(
                height: 2,
                width: 28,
                color: color,
              ),
              const SizedBox(height: 2),
              Container(
                height: 2,
                width: 28,
                color: color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}