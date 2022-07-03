import 'package:flutter/cupertino.dart'; //CupertinoIcons.checkmark_alt_circle,//Success Icon
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

errorPopup(BuildContext context, String? text) {
  MotionToast(
    icon: Icons.error,
    primaryColor: globals.darkBlue2,
    secondaryColor: globals.red1,
    barrierColor: Colors.transparent.withOpacity(0.6),
    toastDuration: const Duration(seconds: 3),
    backgroundType: BackgroundType.solid,
    title: Text(
      'Error',
      style: TextStyle(color: globals.red1, fontWeight: FontWeight.bold),
    ),
    description: Text(
      text ?? 'Unexpected Error.',
      style: TextStyle(color:globals.whiteBlue),
    ),
    position: MotionToastPosition.bottom,
    animationType: AnimationType.fromRight,
    height: 100,
  ).show(context);
}

warningPopup(BuildContext context, String? text) {
  MotionToast(
    icon: Icons.warning,
    primaryColor: globals.darkBlue2,
    secondaryColor: globals.yellow1,
    barrierColor: Colors.transparent.withOpacity(0.6),
    toastDuration: const Duration(seconds: 3),
    backgroundType: BackgroundType.solid,
    title: Text(
      'Warning',
      style: TextStyle(color:globals.yellow1,fontWeight: FontWeight.bold),
    ),
    description: Text(
      text ?? 'Unexpected Warning.',
      style: TextStyle(color:globals.whiteBlue),
    ),
    position: MotionToastPosition.bottom,
    animationType: AnimationType.fromRight,
    height: 100,
  ).show(context);
}

successPopup(BuildContext context, String? text) {
  MotionToast(
    icon: CupertinoIcons.checkmark_alt_circle,
    primaryColor: globals.darkBlue2,
    secondaryColor: globals.green1,
    barrierColor: Colors.transparent.withOpacity(0.6),
    toastDuration: const Duration(seconds: 3),
    backgroundType: BackgroundType.solid,
    title: Text(
      'Success',
      style: TextStyle(color:globals.green1,fontWeight: FontWeight.bold),
    ),
    description: Text(
      text ?? 'Unexpected Success.',
      style: TextStyle(color:globals.whiteBlue),
    ),
    position: MotionToastPosition.bottom,
    animationType: AnimationType.fromRight,
    height: 100,
  ).show(context);
}