import 'package:flutter/material.dart';

class ButtonStyleCustom {
  ButtonStyle call(Color textColor, Color buttonColor) {
    return ButtonStyle(
      textStyle: MaterialStateProperty.resolveWith(
        (states) => TextStyle(
          color: textColor,
        ),
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => buttonColor,
      ),
    );
  }
}
