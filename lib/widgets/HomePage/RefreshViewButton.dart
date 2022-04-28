import 'package:flutter/material.dart';

class RefreshViewButton extends StatelessWidget {
  String text;
  IconData icon;
  Color colorIcon;
  Color colorText;
  bool isClickedRefresh;
  var onTap;

  RefreshViewButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.colorIcon,
      required this.colorText,
      required this.isClickedRefresh,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            isClickedRefresh == false
                ? Icon(
                    icon,
                    color: colorIcon,
                  )
                : SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: CircularProgressIndicator(
                      color: colorIcon,
                    )),
            const SizedBox(width: 25),
            Text(
              text,
              style: TextStyle(
                  fontSize: 18, color: colorText, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
