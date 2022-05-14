library my_wallet.globals;

import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/hexColor/hexColor.dart';
import 'package:kwikcode_programmer_side/widgets/other/Flutter%20Logo.dart';

//Version
const String version = "v1.0";

//Server Ip  (page[/my_api.dart])
const String myIP = "http://147.78.44.3/kwikcode_php";

String currentPage = 'HomePage'; //HomePage


//Colors
final Color blue = Colors.blue.shade50;
final Color blue_1 = Colors.blue.shade900;
final Color blue_2 = Colors.blue.shade900.withOpacity(0.5);
final Color red = Colors.red.shade50;
final Color red_1 = Colors.red.shade900;
final Color red_2 = Colors.red.shade900.withOpacity(0.5);
const Color transparent = Colors.transparent;

Color blue1 = Colors.blue.shade900;
Color blue2 = Colors.blue.shade50;
Color red1 = Colors.red.shade700;
Color red2 = Colors.red.shade50;
Color yellow1 = Colors.yellow.shade700;
Color yellow2 = Colors.yellow.shade50;
Color green1 = Colors.green.shade700;
Color green2 = Colors.green.shade50;

final Color darkBlue1 = HexColor("#1a1a26");
final Color darkBlue2 = HexColor("#242736");
final Color white1 = HexColor("#616570");
final Color white2 = HexColor("#bcbeca");

final Color logoColorPink = HexColor('#cb156f');
final Color logoColorBlue = HexColor('#302ca2');

final Color whiteBlue = HexColor("#f2f3f8");
final Color white = HexColor("#fdfdfd");

//Errors
const String warning1 = "No Spaces Allowed.";
const String warning2_1 = "Your username must contain at least 8 characters.";
const String warning2_2 =
    "Your username can only contain lowercase and uppercase characters and special characters( _ .).";
const String warning2_3 =
    "Your password must contain at least 8 characters, 1 lowercase(a-z),1 uppercase(A-Z),1 numeric character(0-9) and 1 special character(* . ! @ # \$ % ^ & : , ? _ -).";
//const String warning2_4 = "Your age must be greater than 17.";
const String warning2_5 = "It's not an email format.";
//const String warning2_6 = "It's not a university email.";
const String error2_7 = "phone Number already exists";
const String error3 = "Please make sure your passwords match.";
const String error4 =
    "Cannot connect to the dataBase."; // error in insert or delete or update etc...
const String warning5 = "UserName already exist.";
const String warning6 = "Email already exist.";
const String warning7 = "Field cannot be empty.";
const String warning8 = "Incorrect email or password."; // for login
const String error9 = "It's not a phoneNumber format, example: +961########";
const String warning10 = "No data available";
const String error11 = "This email is not Registered";
const String error12 = "Incorrect Email sent";
const String errorToken = "Token Error.";
const String errorVersion = "New version available.";
const String errorElse = "Failed to connect... Connection Problem.";
const String errorException =
    "OOPs! Something went wrong. Try again in few seconds.";
const String codeFailed = "your code is incorrect";
const String codeException =
    "Oops Something went wrong! please try to login again!";

const String warning400 = "You must login first!"; ///////
const String error401 = "Sorry, this day is full."; ///////
const String error402 = "Sorry, this day is not available."; ///////
const String error403 = "Sorry, this course is not available."; ///////
const String success404 = "New course added."; ///////
const String error405 = 'This teacher has no courses yet.';
const String error406 = 'There is no courses available on this day.';
const String warning407 = 'There is no teacehrs available.';
const String success408 = "Payment Done Successfully."; ///////
const String error409 = 'Coupon already claimed!';

final ScrollController controllerMiddlePage = ScrollController();
bool isLoadinTooltip = false;



Color iconColor = white1;
const double _iconSize = 35;

List<Widget> languagesIconsList = [
  Padding(
    padding: const EdgeInsets.all(6.0),
    child: MyFlutterLogo(
      size: _iconSize,
      color: iconColor,
    ),
  ),
  Padding(
    padding: const EdgeInsets.all(6.0),
    child: Icon(
      NewIcons.php,
      size: _iconSize,
      color: iconColor,
    ),
  ),
  Padding(
    padding: const EdgeInsets.all(6.0),
    child: Icon(
      NewIcons.js,
      size: _iconSize,
      color: iconColor,
    ),
  ),
  Padding(
    padding: const EdgeInsets.all(6.0),
    child: Icon(
      NewIcons.react,
      size: _iconSize,
      color: iconColor,
    ),
  ),
  Padding(
    padding: const EdgeInsets.all(6.0),
    child: Icon(
      NewIcons.css3,
      size: _iconSize,
      color: iconColor,
    ),
  ),
  Padding(
    padding: const EdgeInsets.all(6.0),
    child: Icon(
      NewIcons.css3_alt,
      size: _iconSize,
      color: iconColor,
    ),
  ),
  Padding(
    padding: const EdgeInsets.all(6.0),
    child: Icon(
      NewIcons.html5,
      size: _iconSize,
      color: iconColor,
    ),
  ),
  Padding(
    padding: const EdgeInsets.all(6.0),
    child: Icon(
      NewIcons.swift,
      size: _iconSize,
      color: iconColor,
    ),
  ),
  Padding(
    padding: const EdgeInsets.all(6.0),
    child: Icon(
      NewIcons.java,
      size: _iconSize,
      color: iconColor,
    ),
  ),

];