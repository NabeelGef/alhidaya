import 'package:flutter/material.dart';

class Sizer {
  // هون مشان احجام التطبيق العرض والطول
  static getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static getTextSize(BuildContext context, double size) {
    return size *
        (MediaQuery.of(context).size.width / 360) *
        MediaQuery.of(context).textScaleFactor;
  }
  //data
}
//https://github.com/NabeelGef/alhidaya.git