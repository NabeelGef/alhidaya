import 'dart:io';

import 'package:alhidaya/Constant/color.dart';
import 'package:alhidaya/Constant/sizer.dart';
import 'package:alhidaya/Screen/StudentProfile/student_profile.dart';
import 'package:alhidaya/main.dart';
import 'package:flutter/material.dart';

import '../../Constant/code.dart';
import '../../Constant/font.dart';
import '../../Model/Student.dart';
import '../../Model/databasehelper.dart';

class ShowStudent extends StatefulWidget {
  const ShowStudent({super.key});

  @override
  State<ShowStudent> createState() => _ShowStudentState();
}

class _ShowStudentState extends State<ShowStudent> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
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
          appBar: Code.getAppBar(context, scaffoldState, "عرض جميع الطّلاب"),
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
                      Expanded(
                        child: Column(
                          children: [
                            Text("عدد الطّلاب",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Sizer.getTextSize(context, 17),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font.fontfamily)),
                            FutureBuilder<List<Student?>>(
                                future: dp.getAllStudents(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Coloring.secondary,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Text("${snapshot.data!.length}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Sizer.getTextSize(
                                                  context, 20),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: Font.fontfamily)),
                                    );
                                  } else {
                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Coloring.secondary,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Text("انتظر...",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Sizer.getTextSize(
                                                  context, 20),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: Font.fontfamily)),
                                    );
                                  }
                                })
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text("اسم المشرف",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Sizer.getTextSize(context, 18),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font.fontfamily)),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Coloring.secondary,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Text("${data['name']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizer.getTextSize(context, 15),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
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
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Coloring.secondary,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Text("${data['numberRing']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizer.getTextSize(context, 20),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: dp.getAllStudents(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                        child: Image.asset(
                                      "${Font.url}empty.png",
                                      fit: BoxFit.cover,
                                      width: Sizer.getTextSize(context, 250),
                                      height: Sizer.getTextSize(context, 250),
                                    )),
                                  ),
                                  Expanded(
                                    child: Center(
                                        child: Text(
                                      "... لايوجد طلاب بعد ",
                                      style: TextStyle(
                                          fontSize:
                                              Sizer.getTextSize(context, 25),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                                  ),
                                ],
                              );
                            } else {
                              return ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.all(10),
                                      width: Sizer.getWidth(context) / 1.5,
                                      decoration: BoxDecoration(
                                          color: Coloring.secondary,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return StudentProfile(
                                                        student: snapshot
                                                            .data?[index]);
                                                  },
                                                ));
                                              },
                                              child: Icon(
                                                Icons.arrow_back_ios,
                                                color: Colors.black,
                                                size: Sizer.getTextSize(
                                                    context, 25),
                                              )),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  snapshot
                                                      .data![index]?.getName,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          Sizer.getTextSize(
                                                              context, 25),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          Font.fontfamily)),
                                              Text(
                                                  "عدد النّقاط : ${snapshot.data![index]?.getPoints}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          Sizer.getTextSize(
                                                              context, 25),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          Font.fontfamily))
                                            ],
                                          ),
                                          snapshot.data![index]?.profile != null
                                              ? CircleAvatar(
                                                  radius:
                                                      Sizer.getWidth(context) /
                                                          10,
                                                  backgroundImage: FileImage(
                                                      File(snapshot
                                                          .data![index]!
                                                          .profile!)),
                                                )
                                              : Image.asset(
                                                  "${Font.url}pupils.png",
                                                  fit: BoxFit.cover,
                                                  width: Sizer.getTextSize(
                                                      context, 50),
                                                  height: Sizer.getTextSize(
                                                      context, 50),
                                                )
                                        ],
                                      ),
                                    );
                                  });
                            }
                          } else {
                            return Center(
                                child: Text(
                              "لايوجد طلاب بعد ...",
                              style: TextStyle(
                                  fontSize: Sizer.getTextSize(context, 25),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ));
                          }
                        }),
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
