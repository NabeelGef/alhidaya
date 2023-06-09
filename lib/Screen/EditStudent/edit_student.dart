import 'dart:async';
import 'dart:io';

import 'package:alhidaya/Model/Student.dart';
import 'package:alhidaya/Screen/ShowStudent/show_students.dart';
import 'package:flutter/material.dart';

import '../../Constant/code.dart';
import '../../Constant/color.dart';
import '../../Constant/font.dart';
import '../../Constant/sizer.dart';
import '../../Model/AcceptInfo.dart';
import '../../Model/databasehelper.dart';
import '../../main.dart';
import '../StudentProfile/controller_profle.dart';

// ignore: must_be_immutable
class EditStudent extends StatefulWidget {
  Student? student;
  EditStudent({required this.student});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  GlobalKey<FormState> formState = GlobalKey();
  AcceptInfo acceptInfo = AcceptInfo();
  StreamSubscription<bool>? streamSubscription;
  ControllerProfile controllerProfile = ControllerProfile();
  StreamSubscription<File?>? streamSubscriptionfile;

  late TextEditingController name;
  late TextEditingController phoneNumber;
  late TextEditingController className;
  late TextEditingController ringnum;
  late TextEditingController address;
  late TextEditingController work;
  final dp = getIt.get<DataBaseHelper>();
  File? myimage;
  @override
  void initState() {
    name = TextEditingController(text: widget.student?.name);
    phoneNumber =
        TextEditingController(text: "0${widget.student?.phone.toString()}");
    className =
        TextEditingController(text: widget.student?.classname.toString());
    ringnum = TextEditingController(text: widget.student?.ringnum.toString());
    address = TextEditingController(text: widget.student?.address);
    work = TextEditingController(text: widget.student?.work);
    if (widget.student?.profile != null) {
      myimage = File(widget.student!.profile!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void updateState(File? imageFile) {
      setState(() {
        myimage = imageFile;
      });
    }

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
          appBar:
              Code.getAppBar(context, scaffoldState, "تعديل معلومات \n الطالب"),
          body: Container(
            height: Sizer.getHeight(context),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("${Font.url}background2.png"),
                    fit: BoxFit.fill),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            scaffoldState.currentState!.showBottomSheet(
                              (context) {
                                return Code.makeSheet(context, updateState);
                              },
                            );
                          },
                          child: CircleAvatar(
                              radius: Sizer.getWidth(context) / 10,
                              backgroundColor: Coloring.secondary,
                              backgroundImage:
                                  myimage != null ? FileImage(myimage!) : null,
                              child: myimage == null
                                  ? Image.asset(
                                      "${Font.url}addimage.png",
                                      fit: BoxFit.cover,
                                      width: Sizer.getTextSize(context, 50),
                                      height: Sizer.getTextSize(context, 50),
                                    )
                                  : null),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 25),
                        child: Text(
                          "معلومات الطالب",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: Font.fontfamily,
                            fontSize: Sizer.getTextSize(context, 25),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Form(
                        key: formState,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: Sizer.getHeight(context) / 50,
                            ),
                            MakeTextFormField(
                                name, TextInputType.name, "الاسم والكنية", 25),
                            SizedBox(
                              height: Sizer.getHeight(context) / 25,
                            ),
                            MakeTextFormField(phoneNumber, TextInputType.number,
                                "رقم ولي الامر", 10),
                            SizedBox(
                              height: Sizer.getHeight(context) / 25,
                            ),
                            MakeTextFormField(className, TextInputType.number,
                                "الصّفّ الدّراسي", 2),
                            SizedBox(
                              height: Sizer.getHeight(context) / 25,
                            ),
                            MakeTextFormField(
                                ringnum, TextInputType.number, "رقم الحلقة", 2),
                            SizedBox(
                              height: Sizer.getHeight(context) / 25,
                            ),
                            MakeTextFormField(address, TextInputType.text,
                                "عنوان السّكن", 50),
                            SizedBox(
                              height: Sizer.getHeight(context) / 25,
                            ),
                            MakeTextFormField(
                                work, TextInputType.text, "عمل الوالد", 50),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  if (checkValidator(formState)) {
                                    // Alert
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Code.makeAlert(
                                              context,
                                              acceptInfo,
                                              "تمت تعديلات الطالب \n بنجاح");
                                        });
                                    streamSubscription ??= acceptInfo
                                        .onValueChanged
                                        .listen((event) {
                                      if (event) {
                                        Student student = Student(
                                            id: widget.student?.id,
                                            profile: myimage?.path,
                                            name: name.text,
                                            classname:
                                                int.parse(className.text),
                                            address: address.text,
                                            work: work.text,
                                            phone: int.parse(phoneNumber.text),
                                            ringnum: int.parse(ringnum.text),
                                            points: widget.student!.points,
                                            notes: widget.student!.notes);
                                        dp.update(student.toMap());
                                        Navigator.pushAndRemoveUntil(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return ShowStudent();
                                          },
                                        ), (route) => false);
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: Sizer.getTextSize(context, 25)),
                                  width: Sizer.getWidth(context) / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Coloring.secondary,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Image.asset(
                                        "${Font.url}done.png",
                                        fit: BoxFit.cover,
                                        width: Sizer.getTextSize(context, 50),
                                        height: Sizer.getTextSize(context, 50),
                                      ),
                                      Text("حفظ \n التعديلات",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font.fontfamily,
                                            fontSize:
                                                Sizer.getTextSize(context, 20),
                                            color: Colors.black,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  MakeTextFormField(TextEditingController controller, TextInputType type,
      String labelText, int? counter) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "يجب ملئ الحقل ";
        }
        if (labelText == "رقم ولي الامر") {
          if (value.length < 10) {
            return "يجب أن يتألّف من 10 أرقام";
          }
        }
        return null;
      },
      maxLength: counter,
      textDirection: TextDirection.rtl,
      keyboardType: type,
      cursorColor: Colors.black,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: Font.fontfamily,
        fontSize: Sizer.getTextSize(context, 15),
        color: Colors.black,
      ),
      decoration: InputDecoration(
          counterStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: Font.fontfamily,
              fontSize: Sizer.getTextSize(context, 10),
              color: Colors.black),
          errorStyle: TextStyle(
              color: Colors.red,
              fontFamily: Font.fontfamily,
              fontWeight: FontWeight.bold,
              fontSize: Sizer.getTextSize(context, 15)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.transparent)),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: Font.fontfamily,
            fontSize: Sizer.getTextSize(context, 20),
            color: Colors.black,
          ),
          labelText: labelText,
          hintTextDirection: TextDirection.rtl,
          fillColor: Coloring.secondary,
          filled: true),
    );
  }

  bool checkValidator(GlobalKey<FormState> formState) {
    return formState.currentState!.validate();
  }

  @override
  void dispose() {
    print("Dispossse");
    streamSubscription?.cancel();
    super.dispose();
  }
}
