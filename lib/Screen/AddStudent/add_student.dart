import 'dart:async';
import 'dart:io';

import 'package:alhidaya/Constant/color.dart';
import 'package:alhidaya/Constant/sizer.dart';
import 'package:alhidaya/Model/Student.dart';
import 'package:alhidaya/Model/databasehelper.dart';
import 'package:alhidaya/main.dart';
import 'package:flutter/material.dart';

import '../../Constant/code.dart';
import '../../Constant/font.dart';
import '../../Model/AcceptInfo.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  GlobalKey<FormState> formState = GlobalKey();
  AcceptInfo acceptInfo = AcceptInfo();
  StreamSubscription<bool>? streamSubscription;
  StreamSubscription<File?>? streamSubscriptionfile;
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController className = TextEditingController();
  TextEditingController ringnum = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController work = TextEditingController();
  final dp = getIt.get<DataBaseHelper>();

  File? myimage;

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
          appBar: Code.getAppBar(context, scaffoldState, "إضافة طالب"),
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
                                onTap: () async {
                                  if (checkValidator(formState)) {
                                    // Aler
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Code.makeAlert(
                                              context,
                                              acceptInfo,
                                              "تمت إضافة الطّالب\n بنجاح");
                                        });
                                    streamSubscription ??= acceptInfo
                                        .onValueChanged
                                        .listen((event) {
                                      if (event) {
                                        Student student = Student(
                                            profile: myimage?.path,
                                            name: name.text,
                                            classname:
                                                int.parse(className.text),
                                            address: address.text,
                                            work: work.text,
                                            phone: int.parse(phoneNumber.text),
                                            ringnum: int.parse(ringnum.text),
                                            points: 0);
                                        dp.insert(student);
                                        Navigator.of(context).pop();
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
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Image.asset(
                                        "${Font.url}done.png",
                                        fit: BoxFit.cover,
                                        width: Sizer.getTextSize(context, 50),
                                        height: Sizer.getTextSize(context, 50),
                                      ),
                                      Text("حفظ \n المعلومات",
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

  bool checkValidator(GlobalKey<FormState> formState) {
    return formState.currentState!.validate();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    streamSubscriptionfile?.cancel();
    super.dispose();
  }

  MakeTextFormField(TextEditingController controller, TextInputType type,
      String labelText, int? counter) {
    return TextFormField(
      controller: controller,
      maxLength: counter,
      validator: (value) {
        if (value!.isEmpty) {
          return "يجب ملئ الحقل ";
        }
        if (labelText == "رقم ولي الامر") {
          print("LABLE : $labelText");
          if (value.length < 10) {
            return "يجب أن يتألّف من 10 أرقام";
          }
        }
        return null;
      },
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
              fontSize: Sizer.getTextSize(context, 15),
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
}
