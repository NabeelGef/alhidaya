import 'dart:io';

import 'package:alhidaya/Constant/color.dart';
import 'package:alhidaya/Constant/font.dart';
import 'package:alhidaya/Constant/sizer.dart';
import 'package:alhidaya/Screen/MyProfile/controller_myprofile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/AcceptInfo.dart';
import '../Screen/StudentProfile/controller_profle.dart';
import '../main.dart';

class Code {
  static getDrawer(BuildContext context, GlobalKey<ScaffoldState> scaffoldkey) {
    return Drawer(
      width: Sizer.getWidth(context) / 1.5,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("${Font.url}background.png"),
                    fit: BoxFit.fill)),
          ),
          ListView(
            children: [
              SizedBox(
                height: Sizer.getHeight(context) / 2.5,
                child: DrawerHeader(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            scaffoldkey.currentState!.closeEndDrawer();
                          },
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward,
                                size: Sizer.getTextSize(context, 35),
                                color: Colors.white,
                              )),
                        ),
                        CircleAvatar(
                            radius: Sizer.getWidth(context) / 10,
                            backgroundColor: Coloring.secondary,
                            backgroundImage: data['photo'] != null
                                ? FileImage(File(data['photo']!))
                                : null,
                            child: data['photo'] == null
                                ? Image.asset(
                                    "${Font.url}user.png",
                                    fit: BoxFit.cover,
                                    width: Sizer.getTextSize(context, 50),
                                    height: Sizer.getTextSize(context, 50),
                                  )
                                : null),
                        Text("${data['name']}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizer.getTextSize(context, 25),
                                fontWeight: FontWeight.bold,
                                fontFamily: Font.fontfamily)),
                        const Divider(
                          color: Colors.white,
                          thickness: 2,
                        )
                      ]),
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/adult", (route) => false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Coloring.primary,
                      ),
                      margin:
                          EdgeInsets.only(top: Sizer.getTextSize(context, 25)),
                      height: Sizer.getHeight(context) / 15,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "دورة النّاشئة",
                                style: TextStyle(
                                    fontSize: Sizer.getTextSize(context, 20),
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font.fontfamily),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Icon(
                              Icons.groups,
                              color: Colors.black,
                              size: Sizer.getTextSize(context, 35),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/myprofile');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Coloring.primary,
                      ),
                      margin:
                          EdgeInsets.only(top: Sizer.getTextSize(context, 25)),
                      height: Sizer.getHeight(context) / 15,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "الحساب الشّخصي",
                                style: TextStyle(
                                    fontSize: Sizer.getTextSize(context, 20),
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font.fontfamily),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Icon(
                              Icons.account_circle,
                              color: Colors.black,
                              size: Sizer.getTextSize(context, 35),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: Sizer.getTextSize(context, 25)),
                child: CircleAvatar(
                  backgroundColor: Coloring.primary,
                  radius: Sizer.getHeight(context) / 7,
                  child: Image.asset(
                    "${Font.url}alhidaya.png",
                    width: Sizer.getWidth(context) / 3,
                    height: Sizer.getHeight(context) / 3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static getAppBar(BuildContext context, GlobalKey<ScaffoldState> scaffoldState,
      String text) {
    return AppBar(
      actions: [
        InkWell(
          child: Icon(Icons.menu, size: Sizer.getTextSize(context, 50)),
          onTap: () {
            scaffoldState.currentState!.openEndDrawer();
          },
          // set the size of the end drawer icon
        ),
      ],
      elevation: 0,
      toolbarHeight: Sizer.getHeight(context) / 6,
      leadingWidth: Sizer.getWidth(context) / 4,
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset(
          "${Font.url}alhidaya.png",
          width: Sizer.getWidth(context) / 4.5,
          height: Sizer.getHeight(context) / 4.5,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text(
        "$text",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: Sizer.getTextSize(context, 23),
            color: Colors.white,
            fontFamily: Font.fontfamily,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  static Widget makeAlert(
      BuildContext context, AcceptInfo acceptInfo, String text) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        height: Sizer.getHeight(context) / 2,
        width: Sizer.getWidth(context) / 1.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: AssetImage("${Font.url}background.png"),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("${Font.url}accept.png",
                width: Sizer.getWidth(context) / 4,
                height: Sizer.getWidth(context) / 4),
            Text(
              "$text",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: Font.fontfamily,
                  fontSize: Sizer.getTextSize(context, 20),
                  fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                acceptInfo.updateValue();
                Navigator.of(context).pop();
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Coloring.primary,
                      borderRadius: BorderRadius.circular(15)),
                  alignment: Alignment.center,
                  width: Sizer.getWidth(context) / 3,
                  child: Text(
                    "موافق",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizer.getTextSize(context, 20),
                        fontFamily: Font.fontfamily),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Future<File?> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<File?> _getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Widget makeSheet(BuildContext context, Function(File?) selecteImage) {
    ControllerProfile controller = ControllerProfile();
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: Sizer.getWidth(context),
        height: Sizer.getHeight(context) / 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            image: DecorationImage(
                image: AssetImage("${Font.url}background.png"),
                fit: BoxFit.fill)),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          InkWell(
            onTap: () async {
              controller.updateValue(await _getImageFromGallery());
              selecteImage(controller.getImage);
              Navigator.pop(context);
            },
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "اختيار الصورة من المعرض ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizer.getTextSize(context, 25)),
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    "${Font.url}gallery.png",
                    width: Sizer.getWidth(context) / 10,
                    height: Sizer.getWidth(context) / 10,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white,
            thickness: 2,
          ),
          InkWell(
            onTap: () async {
              controller.updateValue(await _getImageFromCamera());
              selecteImage(controller.getImage);
              Navigator.pop(context);
            },
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "اختيار الصورة من الكاميرا ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizer.getTextSize(context, 25)),
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    "${Font.url}camera.png",
                    width: Sizer.getWidth(context) / 10,
                    height: Sizer.getWidth(context) / 10,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  static Widget makeAlertDelete(BuildContext context, AcceptInfo acceptInfo) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        height: Sizer.getHeight(context) / 2,
        width: Sizer.getWidth(context) / 1.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: AssetImage("${Font.url}background2.png"),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 3,
              child: Image.asset(
                "${Font.url}question.png",
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Text(
                "هل تريد تأكيد الحذف ؟",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: Font.fontfamily,
                    fontSize: Sizer.getTextSize(context, 20),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Coloring.secondary,
                          borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.center,
                      width: Sizer.getWidth(context) / 4,
                      height: Sizer.getHeight(context) / 10,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "إلغاء",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizer.getTextSize(context, 20),
                                  fontFamily: Font.fontfamily),
                            ),
                          ),
                          Expanded(
                              child: Image.asset(
                            "${Font.url}close.png",
                            fit: BoxFit.cover,
                            width: Sizer.getTextSize(context, 25),
                            height: Sizer.getTextSize(context, 25),
                          ))
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      acceptInfo.updateValue();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Coloring.secondary,
                          borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.center,
                      width: Sizer.getWidth(context) / 4,
                      height: Sizer.getHeight(context) / 10,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "تأكيد",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizer.getTextSize(context, 20),
                                  fontFamily: Font.fontfamily),
                            ),
                          ),
                          Expanded(
                              child: Image.asset(
                            "${Font.url}done.png",
                            fit: BoxFit.cover,
                            width: Sizer.getTextSize(context, 25),
                            height: Sizer.getTextSize(context, 25),
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget makeAlertEditNameAndNumber(
      BuildContext context,
      ControllerMyProfile controllerMyProfile,
      AcceptInfo acceptInfo,
      TextEditingController controllerName,
      TextEditingController controllerPhone,
      GlobalKey<FormState> formstate) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        height: Sizer.getHeight(context) / 2,
        width: Sizer.getWidth(context) / 1.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: AssetImage("${Font.url}background.png"),
                fit: BoxFit.fill)),
        child: Form(
            key: formstate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: Sizer.getWidth(context) / 1.5,
                  child: TextFormField(
                    maxLength: 20,
                    textDirection: TextDirection.rtl,
                    controller: controllerName,
                    cursorColor: Colors.black,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizer.getTextSize(context, 20),
                        fontFamily: Font.fontfamily),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " يجب ملأ هذا الحقل ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.person_2,
                          size: Sizer.getTextSize(context, 20),
                        ),
                        counterStyle: TextStyle(
                            color: Colors.red,
                            fontFamily: Font.fontfamily,
                            fontWeight: FontWeight.bold,
                            fontSize: Sizer.getTextSize(context, 15)),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: Coloring.secondary,
                        errorStyle: TextStyle(
                            color: Colors.red,
                            fontFamily: Font.fontfamily,
                            fontWeight: FontWeight.bold,
                            fontSize: Sizer.getTextSize(context, 10)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                        hintText: "إسم المشرف الجديد",
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizer.getTextSize(context, 20),
                            fontFamily: Font.fontfamily)),
                  ),
                ),
                Container(
                  width: Sizer.getWidth(context) / 1.5,
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    textDirection: TextDirection.rtl,
                    controller: controllerPhone,
                    cursorColor: Colors.black,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizer.getTextSize(context, 20),
                        fontFamily: Font.fontfamily),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " يجب ملأ هذا الحقل ";
                      }
                      if (value.length < 10) {
                        return " يجب أن يتألّف من 10 أرقام";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.phone,
                          size: Sizer.getTextSize(context, 20),
                        ),
                        counterStyle: TextStyle(
                            color: Colors.red,
                            fontFamily: Font.fontfamily,
                            fontWeight: FontWeight.bold,
                            fontSize: Sizer.getTextSize(context, 15)),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: Coloring.secondary,
                        errorStyle: TextStyle(
                            color: Colors.red,
                            fontFamily: Font.fontfamily,
                            fontWeight: FontWeight.bold,
                            fontSize: Sizer.getTextSize(context, 10)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                        hintText: "رقم الموبايل الجديد",
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizer.getTextSize(context, 20),
                            fontFamily: Font.fontfamily)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Coloring.secondary,
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          width: Sizer.getWidth(context) / 4,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "إلغاء",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Sizer.getTextSize(context, 20),
                                      fontFamily: Font.fontfamily),
                                ),
                              ),
                              Expanded(
                                  child: Image.asset("${Font.url}close.png"))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (formstate.currentState!.validate()) {
                            controllerMyProfile.setterName(controllerName.text);
                            controllerMyProfile
                                .setterPhone(controllerPhone.text);
                            acceptInfo.updateValue();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Coloring.secondary,
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          width: Sizer.getWidth(context) / 4,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "تأكيد",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Sizer.getTextSize(context, 20),
                                      fontFamily: Font.fontfamily),
                                ),
                              ),
                              Expanded(
                                  child: Image.asset("${Font.url}done.png"))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  static Widget makeAlertRing(
      BuildContext context,
      TextEditingController controllerRing,
      String hint,
      int state,
      ControllerMyProfile myProfile,
      GlobalKey<FormState> formstate) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        alignment: Alignment.center,
        height: Sizer.getHeight(context) / 3.5,
        width: Sizer.getWidth(context) / 1.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: AssetImage("${Font.url}background.png"),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formstate,
              child: Container(
                width: Sizer.getWidth(context) / 1.5,
                child: TextFormField(
                  keyboardType:
                      state == 1 ? TextInputType.name : TextInputType.number,
                  maxLength: state == 1 ? 30 : 3,
                  textDirection: TextDirection.rtl,
                  controller: controllerRing,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizer.getTextSize(context, 20),
                      fontFamily: Font.fontfamily),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " يجب ملأ هذا الحقل ";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      counterStyle: TextStyle(
                          color: Colors.red,
                          fontFamily: Font.fontfamily,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizer.getTextSize(context, 15)),
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Coloring.secondary,
                      errorStyle: TextStyle(
                          color: Colors.red,
                          fontFamily: Font.fontfamily,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizer.getTextSize(context, 15)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintText: hint,
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizer.getTextSize(context, 20),
                          fontFamily: Font.fontfamily)),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Coloring.secondary,
                          borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.center,
                      width: Sizer.getWidth(context) / 4,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "إلغاء",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizer.getTextSize(context, 20),
                                  fontFamily: Font.fontfamily),
                            ),
                          ),
                          Expanded(child: Image.asset("${Font.url}close.png"))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (formstate.currentState!.validate()) {
                        if (state == 1) {
                          myProfile.setterNameRing(controllerRing.text);
                        } else if (state == 2) {
                          myProfile.setterNumRing(controllerRing.text);
                        } else {
                          myProfile.setterStateRing(controllerRing.text);
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Coloring.secondary,
                          borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.center,
                      width: Sizer.getWidth(context) / 4,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "تأكيد",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizer.getTextSize(context, 20),
                                  fontFamily: Font.fontfamily),
                            ),
                          ),
                          Expanded(child: Image.asset("${Font.url}done.png"))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
