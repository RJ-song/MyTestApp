import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TextToast{
  static show(String content, {int duration = 3} ) {
    Fluttertoast.showToast(
      msg: content,
      timeInSecForIosWeb: duration,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

}