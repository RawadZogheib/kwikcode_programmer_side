import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class AdminPMButton extends StatefulWidget {
  String text;
  IconData icon;

  AdminPMButton({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  State<AdminPMButton> createState() => _AdminPMButtonState();
}

class _AdminPMButtonState extends State<AdminPMButton> {
  double _height = 35;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => _onTap(),
      onHover: (val) => _onHover(val),
      child: Container(
        height: _height,
        width: 50,
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: globals.logoColorBlue,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _height == 105
                ? const SizedBox(height: 10.0)
                : const SizedBox.shrink(),
            Expanded(
              child: RotatedBox(
                quarterTurns: -1,
                child: _height == 105
                    ? Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: globals.white2,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ),
            // _height == 105
            //     ? const SizedBox(height: 0.0)
            //     : const SizedBox.shrink(),
            SizedBox(
                height: 35,
                width: 35,
                child: Icon(widget.icon, color: globals.white2,))
          ],
        ),
      ),
    );
  }

  _onHover(bool val) {
    setState(() {
      _height = val == true ? 105 : 35;
    });
  }

  _onTap() {
    debugPrint(widget.text);
  }
}
