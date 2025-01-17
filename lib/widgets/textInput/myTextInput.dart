import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class MyTextInput extends StatelessWidget {
  var textString;
  var onChange;
  var keybType;
  bool spaceAllowed;
  bool obscure;
  var maxLength;
  var maxLines;
  var colBlue, colBlue_1;
  var textInputAction;
  var labelText;
  var prefixText;

  MyTextInput(
      {required this.textString,
      required this.labelText,
      this.keybType,
      this.maxLength,
      this.maxLines,
      required this.colBlue,
      required this.colBlue_1,
      this.textInputAction,
      this.prefixText,
      required this.spaceAllowed,
      required this.obscure,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      textAlign: TextAlign.left,
      cursorColor: globals.logoColorPink,
      decoration: InputDecoration(
        hintText: textString,
        hintStyle: TextStyle(fontSize: 14.0, color: colBlue_1),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colBlue).scale(2.0),
            borderRadius: BorderRadius.circular(10.0)),
        filled: true,
        fillColor: colBlue,
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(labelText,style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
          ],
        ),
        alignLabelWithHint: true,
        labelStyle: TextStyle(fontSize: 14.0, color: colBlue_1),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colBlue_1).scale(2.0),
            borderRadius: BorderRadius.circular(10)),
        prefixText: prefixText,
      ),
      textInputAction: textInputAction,
      keyboardType: keybType,
      obscureText: obscure,
      maxLength: maxLength,
      maxLines: maxLines,
      inputFormatters: [
        if (spaceAllowed == false)
          FilteringTextInputFormatter.deny(RegExp(r"\s")),
      ],
    );
  }
}

class MyTextInput2 extends StatelessWidget {
  var textString;
  var onChange;
  var keybType;
  bool spaceAllowed;
  bool enterAllowed;
  bool obscure;
  var maxLength;
  var maxLines;
  var colBlue, colBlue_1, colBlue_2;
  var textInputAction;
  var labelText;
  var prefixText;
  var initialValue;

  MyTextInput2(
      {required this.initialValue,
      required this.textString,
      required this.labelText,
      this.keybType,
      this.maxLength,
      this.maxLines,
      required this.colBlue,
      required this.colBlue_1,
      required this.colBlue_2,
      this.textInputAction,
      this.prefixText,
      required this.spaceAllowed,
      required this.enterAllowed,
      required this.obscure,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(initialValue),
      initialValue: initialValue!,
      autofocus: true,
      onChanged: onChange,
      textAlign: TextAlign.left,
      cursorColor: Colors.black,
      style: TextStyle(color: globals.blue_1),
      decoration: InputDecoration(
        hintText: textString,
        hintStyle: TextStyle(fontSize: 14.0, color: colBlue_1),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colBlue),
            borderRadius: BorderRadius.circular(10.0)),
        filled: true,
        fillColor: colBlue,
        labelText: labelText,
        alignLabelWithHint: true,
        labelStyle: TextStyle(fontSize: 14.0, color: colBlue_1),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colBlue_1),
            borderRadius: BorderRadius.circular(10)),
        prefixText: prefixText,
      ),
      textInputAction: textInputAction,
      keyboardType: keybType,
      obscureText: obscure,
      maxLength: maxLength,
      maxLines: maxLines,
      inputFormatters: [
        if (spaceAllowed == false)
          FilteringTextInputFormatter.deny(RegExp(r"\s")),
        if (enterAllowed == false)
          FilteringTextInputFormatter.deny(RegExp(r"\n")),
      ],
    );
  }
}
