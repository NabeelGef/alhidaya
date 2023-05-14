import 'package:flutter/material.dart';

class Sizer {
  // هون مشان احجام التطبيق العرض والطول
  static getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
//https://github.com/NabeelGef/alhidaya.git