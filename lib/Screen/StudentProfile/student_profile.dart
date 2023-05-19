import 'dart:async';
import 'dart:io';

import 'package:alhidaya/Constant/color.dart';
import 'package:alhidaya/Screen/EditStudent/edit_student.dart';
import 'package:alhidaya/main.dart';
import 'package:flutter/material.dart';

import 'package:alhidaya/Model/Student.dart';

import '../../Constant/code.dart';
import '../../Constant/font.dart';
import '../../Constant/sizer.dart';
import '../../Model/AcceptInfo.dart';
import '../../Model/databasehelper.dart';
import '../ShowStudent/show_students.dart';

// ignore: must_be_immutable
class StudentProfile extends StatefulWidget {
  Student? student;
  StudentProfile({
    required this.student,
  });
  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AcceptInfo acceptInfo = AcceptInfo();
  StreamSubscription<bool>? streamSubscription;
  final dp = getIt.get<DataBaseHelper>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("${Font.url}background.png"))),
        ),
        Scaffold(
          key: scaffoldState,
          backgroundColor: Colors.transparent,
          endDrawer: Code.getDrawer(context, scaffoldState),
          appBar: Code.getAppBar(context, scaffoldState, "صفحة الطالب"),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("${Font.url}background2.png"),
                        fit: BoxFit.fill),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("حذف",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizer.getTextSize(context, 20),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily)),
                          InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Code.makeAlertDelete(
                                          context, acceptInfo);
                                    });
                                streamSubscription ??=
                                    acceptInfo.onValueChanged.listen((event) {
                                  if (event) {
                                    dp.delete(widget.student!.id!);
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return ShowStudent();
                                      },
                                    ), (route) => false);
                                  }
                                });
                              },
                              child: Image.asset("${Font.url}close.png"))
                        ],
                      ),
                      Column(
                        children: [
                          Text("حفظ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizer.getTextSize(context, 20),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily)),
                          Image.asset("${Font.url}save.png")
                        ],
                      ),
                      Column(
                        children: [
                          Text("تعديل",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizer.getTextSize(context, 20),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily)),
                          InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EditStudent(student: widget.student);
                                }));
                              },
                              child: Image.asset("${Font.url}edit.png"))
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Coloring.secondary,
                      radius: Sizer.getWidth(context) / 10,
                      backgroundImage: widget.student?.profile != null
                          ? FileImage(File(widget.student!.profile!))
                          : null,
                      child: widget.student?.profile == null
                          ? Image.asset("${Font.url}pupils.png")
                          : null,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("الصف الدّراسي",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Sizer.getTextSize(context, 17),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font.fontfamily)),
                            Container(
                              width: Sizer.getWidth(context) / 5,
                              height: Sizer.getHeight(context) / 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Coloring.secondary,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Text(widget.student!.getClassname,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizer.getTextSize(context, 15),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily)),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text("اسم الطالب",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Sizer.getTextSize(context, 20),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font.fontfamily)),
                            Container(
                              width: Sizer.getWidth(context) / 2,
                              height: Sizer.getHeight(context) / 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Coloring.secondary,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Text(widget.student!.getName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizer.getTextSize(context, 15),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily)),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("رقم الحلقة",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Sizer.getTextSize(context, 20),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font.fontfamily)),
                            Container(
                              width: Sizer.getWidth(context) / 5,
                              height: Sizer.getHeight(context) / 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Coloring.secondary,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Text(widget.student!.getRingnum.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizer.getTextSize(context, 15),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      width: Sizer.getWidth(context) / 1.1,
                      child: Form(
                          child: TextFormField(
                        cursorColor: Colors.black,
                        maxLines: 10,
                        textDirection: TextDirection.rtl,
                        initialValue: widget.student?.getNotes,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizer.getTextSize(context, 15),
                            fontWeight: FontWeight.bold,
                            fontFamily: Font.fontfamily),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Coloring.secondary,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 10.0,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 10.0,
                              ),
                            ),
                            hintText: "أدخل ملاحظاتك حول الطّالب ",
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: Sizer.getTextSize(context, 15),
                                fontWeight: FontWeight.bold,
                                fontFamily: Font.fontfamily)),
                      )),
                    ),
                  ),
                  Image.asset(
                    "${Font.url}star.png",
                  ),
                  Text("مجموع النّقاط",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Sizer.getTextSize(context, 20),
                          fontWeight: FontWeight.bold,
                          fontFamily: Font.fontfamily)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "${Font.url}minus.png",
                      ),
                      Text(widget.student!.getPoints.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizer.getTextSize(context, 35),
                              fontWeight: FontWeight.bold,
                              fontFamily: Font.fontfamily)),
                      Image.asset("${Font.url}plus.png"),
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}