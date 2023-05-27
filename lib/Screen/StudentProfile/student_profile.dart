import 'dart:async';
import 'dart:io';

import 'package:alhidaya/Constant/color.dart';
import 'package:alhidaya/Screen/EditStudent/edit_student.dart';
import 'package:alhidaya/Screen/StudentProfile/controller_profle.dart';
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
  ControllerProfile controllerProfile = ControllerProfile();
  StreamSubscription<int>? streamSubscriptionpoint;
  late TextEditingController controllerNotes;
  late int mypoint;
  final dp = getIt.get<DataBaseHelper>();
  @override
  void initState() {
    mypoint = widget.student!.points;
    if (widget.student!.notes != null) {
      controllerNotes = TextEditingController(text: widget.student!.notes);
    } else {
      controllerNotes = TextEditingController();
    }
    controllerProfile.setterPoint(mypoint);
    super.initState();
  }

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
              SingleChildScrollView(
                child: Column(
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
                                child: Image.asset(
                                  "${Font.url}close.png",
                                  fit: BoxFit.cover,
                                  width: Sizer.getTextSize(context, 50),
                                  height: Sizer.getTextSize(context, 50),
                                ))
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
                            InkWell(
                                onTap: () {
                                  Student st = Student(
                                      id: widget.student?.id,
                                      profile: widget.student?.profile,
                                      name: widget.student!.name,
                                      classname: widget.student!.classname,
                                      address: widget.student!.address,
                                      work: widget.student!.work,
                                      phone: widget.student!.phone,
                                      ringnum: widget.student!.ringnum,
                                      points: mypoint,
                                      notes: controllerNotes.text);
                                  dp.update(st.toMap());
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return ShowStudent();
                                    },
                                  ), (route) => false);
                                },
                                child: Image.asset(
                                  "${Font.url}save.png",
                                  fit: BoxFit.cover,
                                  width: Sizer.getTextSize(context, 50),
                                  height: Sizer.getTextSize(context, 50),
                                ))
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
                                child: Image.asset(
                                  "${Font.url}edit.png",
                                  fit: BoxFit.cover,
                                  width: Sizer.getTextSize(context, 50),
                                  height: Sizer.getTextSize(context, 50),
                                ))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
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
                            ? Image.asset(
                                "${Font.url}pupils.png",
                                fit: BoxFit.cover,
                                width: Sizer.getTextSize(context, 50),
                                height: Sizer.getTextSize(context, 50),
                              )
                            : null,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text("الصف ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizer.getTextSize(context, 18),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily)),
                              Container(
                                width: Sizer.getWidth(context) / 5,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Coloring.secondary,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Text(
                                    widget.student!.getClassname.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            Sizer.getTextSize(context, 15),
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
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Coloring.secondary,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Text(widget.student!.getName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            Sizer.getTextSize(context, 15),
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
                                      fontSize: Sizer.getTextSize(context, 18),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily)),
                              Container(
                                width: Sizer.getWidth(context) / 5,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Coloring.secondary,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Text(
                                    widget.student!.getRingnum.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            Sizer.getTextSize(context, 15),
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
                    Container(
                      height: Sizer.getHeight(context) / 3,
                      width: Sizer.getWidth(context) / 1.1,
                      child: Form(
                          child: TextFormField(
                        cursorColor: Colors.black,
                        maxLines: 10,
                        maxLength: 250,
                        textDirection: TextDirection.rtl,
                        controller: controllerNotes,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizer.getTextSize(context, 15),
                            fontWeight: FontWeight.bold,
                            fontFamily: Font.fontfamily),
                        decoration: InputDecoration(
                            counterStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: Sizer.getTextSize(context, 15),
                                fontFamily: Font.fontfamily),
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
                    Image.asset(
                      "${Font.url}star.png",
                      fit: BoxFit.cover,
                      width: Sizer.getTextSize(context, 50),
                      height: Sizer.getTextSize(context, 50),
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
                        InkWell(
                          onTap: () {
                            controllerProfile.minusPoint();
                            streamSubscriptionpoint ??= controllerProfile
                                .onValueChanged
                                .listen((event) {
                              mypoint = event;
                              setState(() {});
                            });
                          },
                          child: Image.asset(
                            "${Font.url}minus.png",
                            fit: BoxFit.cover,
                            width: Sizer.getTextSize(context, 50),
                            height: Sizer.getTextSize(context, 50),
                          ),
                        ),
                        Text(mypoint.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Sizer.getTextSize(context, 35),
                                fontWeight: FontWeight.bold,
                                fontFamily: Font.fontfamily)),
                        InkWell(
                            onTap: () {
                              controllerProfile.addPoint();
                              streamSubscriptionpoint ??= controllerProfile
                                  .onValueChanged
                                  .listen((event) {
                                mypoint = event;
                                setState(() {});
                              });
                            },
                            child: Image.asset(
                              "${Font.url}plus.png",
                              fit: BoxFit.cover,
                              width: Sizer.getTextSize(context, 50),
                              height: Sizer.getTextSize(context, 50),
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
