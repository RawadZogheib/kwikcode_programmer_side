import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/other/StrikeThroughWidget2.dart';

class ToolTipWidget extends StatelessWidget {
  int index;

  String usdAmount;
  String kpAmount;
  String time;
  String totalTime;

  ToolTipWidget({
    Key? key,
    required this.index,
    required this.usdAmount,
    required this.kpAmount,
    required this.time,
    required this.totalTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 110,
              width: 220,
              child: index >= 0 && index <= 3
                  ? CustomPaint(
                      foregroundPainter: index == 0
                          ? MyPainter0()
                          : index == 1
                              ? MyPainter1()
                              : index == 2
                                  ? MyPainter2()
                                  : MyPainter3(),
                    )
                  : const SizedBox(),
            ),
            Row(
              children: [
                SizedBox(
                  width: index == 0
                      ? 0
                      : index == 1
                          ? 25
                          : index == 2
                              ? 25
                              : 35,
                ),
                SizedBox(
                  height: 110,
                  width: index == 0
                      ? 175
                      : index == 1
                          ? 175
                          : index == 2
                              ? 175
                              : 175,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 35,
                            child: Text(
                              '\$',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.transparent.withOpacity(1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            usdAmount,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.transparent.withOpacity(1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 35,
                            child: StrikeThroughWidget2(
                              color: Colors.transparent.withOpacity(1),
                              child: Text(
                                'KP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.transparent.withOpacity(1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            kpAmount,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.transparent.withOpacity(1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 1,
              left: index != 0 ? 15 : 1,
              child: Tooltip(
                message:
                    'If you finish the task in $totalTime Day${int.parse(totalTime) > 1 ? 's' : ''}\n you will ${int.parse(usdAmount) >= 0 ? 'receive' : 'be charged'} $usdAmount US dollar \n and ${(int.parse(kpAmount) >= 0 && int.parse(usdAmount) >= 0) || (int.parse(kpAmount) < 0 && int.parse(usdAmount) < 0) ? '' : int.parse(kpAmount) >= 0 ? 'receive' : 'be charged'} $kpAmount KwikPoints.',
                child: Icon(
                  Icons.info_outline,
                  color: Colors.transparent.withOpacity(1),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        index != 3
            ? Row(
                children: [
                  SizedBox(
                    height: 10,
                    width: 175,
                    child: CustomPaint(
                      foregroundPainter: MyPainter00(),
                    ),
                  ),
                  const SizedBox(width: 45),
                ],
              )
            : SizedBox(
                height: 10,
                width: 220,
                child: CustomPaint(
                  foregroundPainter: MyPainter00(),
                ),
              ),
        index != 3
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 175,
                    margin: const EdgeInsets.all(12.0),
                    alignment: Alignment.center,
                    child: Text(
                      '${index!=0?'+ ':''}$time Day${int.parse(time) > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: globals.whiteBlue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 45),
                ],
              )
            : Container(
                width: 220,
                margin: const EdgeInsets.all(12.0),
                alignment: Alignment.center,
                child: Text(
                  '${index!=0?'+ ':''}$time Day${int.parse(time) > 1 ? 's' : ''}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: globals.whiteBlue,
                  ),
                ),
              ),
      ],
    );
  }
}

class MyPainter0 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 4 / 5, size.height);
    path.lineTo(size.width, size.height * 1 / 2);
    path.lineTo(size.width * 4 / 5, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MyPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 1 / 5, size.height * 1 / 2);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 4 / 5, size.height);
    path.lineTo(size.width, size.height * 1 / 2);
    path.lineTo(size.width * 4 / 5, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MyPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 1 / 5, size.height * 1 / 2);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 4 / 5, size.height);
    path.lineTo(size.width, size.height * 1 / 2);
    path.lineTo(size.width * 4 / 5, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MyPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 1 / 5, size.height * 1 / 2);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MyPainter00 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint()
      ..color = globals.whiteBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
