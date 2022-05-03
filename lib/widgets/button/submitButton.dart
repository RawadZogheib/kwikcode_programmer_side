import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart'  as globals;
import 'package:kwikcode_programmer_side/widgets/PopUp/ContainerApplication.dart';

class submitButton extends StatelessWidget {

  var submitBtnText;
  submitButton({required this.submitBtnText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: globals.white2,
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                border: Border.all(color: globals.white1, width: 4)),
            child: Center(
              child: Text(
                submitBtnText,
                style: TextStyle(fontSize: 19 , color: globals.white1),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        //_launchApp();
        showDialog(
            context: context,
            builder: (BuildContext context) => const ContainerApplication());
      },
    );
  }
}

