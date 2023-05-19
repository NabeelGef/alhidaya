import 'dart:io';

import 'package:alhidaya/Constant/color.dart';
import 'package:alhidaya/Constant/font.dart';
import 'package:alhidaya/Constant/sizer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/AcceptInfo.dart';
import '../Screen/StudentProfile/controller_profle.dart';

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
                height: Sizer.getHeight(context) / 3,
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
                          backgroundColor: Colors.transparent,
                          child: Image.asset("${Font.url}user.png"),
                        ),
                        Text("محمد نبيل الغفري",
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
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, "/adult", (route) => false);
                    },
                    child: Container(
                      margin:
                          EdgeInsets.only(top: Sizer.getTextSize(context, 25)),
                      height: Sizer.getHeight(context) / 15,
                      color: Coloring.primary,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "الصفحة الرّئيسيّة",
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
                              Icons.home,
                              color: Colors.black,
                              size: Sizer.getTextSize(context, 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/adult", (route) => false);
                    },
                    child: Container(
                      margin:
                          EdgeInsets.only(top: Sizer.getTextSize(context, 25)),
                      height: Sizer.getHeight(context) / 15,
                      color: Coloring.primary,
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
                              size: Sizer.getTextSize(context, 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: Sizer.getTextSize(context, 25)),
                    height: Sizer.getHeight(context) / 15,
                    color: Coloring.primary,
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
                            size: Sizer.getTextSize(context, 25),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: Sizer.getTextSize(context, 25)),
                child: CircleAvatar(
                  backgroundColor: Coloring.primary,
                  radius: Sizer.getWidth(context) / 4,
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
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldState.currentState!.openEndDrawer();
          },
          iconSize: Sizer.getTextSize(
              context, 50), // set the size of the end drawer icon
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
      backgroundColor: Colors.transparent,
      title: Text(
        "$text",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: Sizer.getTextSize(context, 25),
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
        height: Sizer.getHeight(context) / 3.1,
        width: Sizer.getWidth(context) / 1.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: AssetImage("${Font.url}background.png"),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("${Font.url}accept.png",
                width: Sizer.getWidth(context) / 3,
                height: Sizer.getWidth(context) / 3),
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
    return Container(
      width: Sizer.getWidth(context),
      height: Sizer.getHeight(context) / 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          image: DecorationImage(
              image: AssetImage("${Font.url}background.png"),
              fit: BoxFit.fill)),
      child: Column(children: [
        ListTile(
          onTap: () async {
            controller.updateValue(await _getImageFromGallery());
            selecteImage(controller.getImage);
            Navigator.pop(context);
          },
          tileColor: Coloring.primary,
          trailing: Text(
            "اختيار الصورة من المعرض ",
            style: TextStyle(
                color: Colors.white, fontSize: Sizer.getTextSize(context, 25)),
          ),
          title: Image.asset(
            "${Font.url}gallery.png",
            width: Sizer.getWidth(context) / 10,
            height: Sizer.getWidth(context) / 10,
          ),
        ),
        Divider(
          color: Colors.white,
          thickness: 2,
        ),
        ListTile(
          onTap: () async {
            controller.updateValue(await _getImageFromCamera());
            selecteImage(controller.getImage);
            Navigator.pop(context);
          },
          trailing: Text("اختيار الصورة من الكاميرا ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizer.getTextSize(context, 25))),
          title: Image.asset(
            "${Font.url}camera.png",
            width: Sizer.getWidth(context) / 10,
            height: Sizer.getWidth(context) / 10,
          ),
        ),
      ]),
    );
  }

  static Widget makeAlertDelete(BuildContext context, AcceptInfo acceptInfo) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        height: Sizer.getHeight(context) / 3.1,
        width: Sizer.getWidth(context) / 1.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: AssetImage("${Font.url}background2.png"),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("${Font.url}question.png",
                width: Sizer.getWidth(context) / 3,
                height: Sizer.getWidth(context) / 3),
            Text(
              "تأكيد حذف الطّالب",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: Font.fontfamily,
                  fontSize: Sizer.getTextSize(context, 20),
                  fontWeight: FontWeight.bold),
            ),
            Row(
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "إلغاء",
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "تأكيد",
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
