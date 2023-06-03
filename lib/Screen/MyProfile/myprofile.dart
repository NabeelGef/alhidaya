import 'dart:async';
import 'dart:io';

import 'package:alhidaya/Constant/color.dart';
import 'package:alhidaya/Constant/sizer.dart';
import 'package:alhidaya/Model/AcceptInfo.dart';
import 'package:alhidaya/Model/sharedbase.dart';
import 'package:alhidaya/Screen/LoginScreen/login.dart';
import 'package:alhidaya/Screen/MyProfile/controller_myprofile.dart';
import 'package:alhidaya/main.dart';
import 'package:flutter/material.dart';

import '../../Constant/code.dart';
import '../../Constant/font.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  StreamSubscription<bool>? streamSubscription;
  File? myimage;
  late String? name;
  late String? numberPhone;
  late String? ringName;
  late String? numRing;
  late String? photo;
  late String? stateRing;
  late ControllerMyProfile controllerMyProfile;
  StreamSubscription<String>? streamSubscriptionName;
  StreamSubscription<String>? streamSubscriptionPhone;
  StreamSubscription<String>? streamSubscriptionNumberRing;
  StreamSubscription<String>? streamSubscriptionNameRing;
  StreamSubscription<String>? streamSubscriptionStateRing;

  AcceptInfo acceptInfo = AcceptInfo();
  AcceptInfo acceptInfoForDelete = AcceptInfo();
  StreamSubscription<bool>? streamSubscriptionAccept;
  late TextEditingController controllerName;
  late TextEditingController controllerPhone;
  late TextEditingController controllerRingName;
  late TextEditingController controllerRingNumber;
  late TextEditingController controllerStateNumber;
  GlobalKey<FormState> formstate = GlobalKey();

  @override
  void initState() {
    name = data['name'];
    numberPhone = data['phoneNumber'];
    ringName = data['nameRing'];
    numRing = data['numberRing'];
    photo = data['photo'];
    stateRing = data['stateRing'];
    if (photo != null) {
      myimage = File(photo!);
    }
    controllerMyProfile =
        ControllerMyProfile(name, numberPhone, ringName, numRing, stateRing);
    controllerName = TextEditingController(text: name);
    controllerPhone = TextEditingController(text: numberPhone);
    controllerRingName = TextEditingController(text: ringName);
    controllerRingNumber = TextEditingController(text: numRing);
    controllerStateNumber = TextEditingController(text: stateRing);

    super.initState();
  }

  @override
  void dispose() {
    controllerName.clear();
    controllerPhone.clear();
    controllerRingName.clear();
    controllerRingNumber.clear();
    controllerStateNumber.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void updateState(File? imageFile) {
      setState(() {
        myimage = imageFile;
        if (myimage != null) {
          SharedBase.editPhoto(myimage!.path);
        }
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
          appBar: Code.getAppBar(context, scaffoldState, "صفحة المشرف"),
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
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
                                    "${Font.url}user.png",
                                    fit: BoxFit.cover,
                                    width: Sizer.getTextSize(context, 50),
                                    height: Sizer.getTextSize(context, 50),
                                  )
                                : null),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "$name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizer.getTextSize(context, 20),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily),
                            ),
                            Text(
                              "$numberPhone",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizer.getTextSize(context, 20),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Code.makeAlertEditNameAndNumber(
                                      context,
                                      controllerMyProfile,
                                      acceptInfo,
                                      controllerName,
                                      controllerPhone,
                                      formstate);
                                });
                            streamSubscriptionAccept ??=
                                acceptInfo.onValueChanged.listen((event) {
                              streamSubscriptionName ??= controllerMyProfile
                                  .onValueNameChanged
                                  .listen((event) {
                                name = event;
                                SharedBase.editName(name!);
                                setState(() {});
                              });
                              streamSubscriptionPhone ??= controllerMyProfile
                                  .onValuePhoneChanged
                                  .listen((event) {
                                numberPhone = event;
                                SharedBase.editNumberPhone(numberPhone!);
                                setState(() {});
                              });
                            });
                          },
                          child: CircleAvatar(
                              backgroundColor: Coloring.secondary,
                              radius: Sizer.getTextSize(context, 15),
                              child: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: Sizer.getTextSize(context, 20),
                              )),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey[800], thickness: 3, height: 2),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Code.makeAlertRing(
                                    context,
                                    controllerRingNumber,
                                    "ادخل رقم الحلقة الجديد ",
                                    2,
                                    controllerMyProfile,
                                    formstate);
                              },
                            );

                            streamSubscriptionNumberRing ??= controllerMyProfile
                                .onValueNumRingChanged
                                .listen((event) {
                              numRing = event;
                              SharedBase.editNumberRing(numRing!);
                              setState(() {});
                            });
                          },
                          child: SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Coloring.secondary,
                                  borderRadius: BorderRadius.circular(15)),
                              height: Sizer.getHeight(context) / 4.5,
                              width: Sizer.getWidth(context) / 3,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text("تعديل رقم الحلقة",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                Sizer.getTextSize(context, 20),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font.fontfamily)),
                                    Icon(Icons.edit_document,
                                        size: Sizer.getTextSize(context, 25)),
                                    Text("$numRing",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize:
                                                Sizer.getTextSize(context, 15),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font.fontfamily))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Code.makeAlertRing(
                                    context,
                                    controllerStateNumber,
                                    "ادخل مستوى الحلقة الجديد ",
                                    3,
                                    controllerMyProfile,
                                    formstate);
                              },
                            );

                            streamSubscriptionStateRing ??= controllerMyProfile
                                .onValueStateRingChanged
                                .listen((event) {
                              stateRing = event;
                              SharedBase.editState(stateRing!);
                              setState(() {});
                            });
                          },
                          child: SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Coloring.secondary,
                                  borderRadius: BorderRadius.circular(15)),
                              height: Sizer.getHeight(context) / 4.5,
                              width: Sizer.getWidth(context) / 3,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text("تعديل المستوى ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                Sizer.getTextSize(context, 20),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font.fontfamily)),
                                    Icon(Icons.edit_document,
                                        size: Sizer.getTextSize(context, 25)),
                                    Text("$stateRing",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize:
                                                Sizer.getTextSize(context, 15),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font.fontfamily))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Code.makeAlertRing(
                                    context,
                                    controllerRingName,
                                    "ادخل اسم الحلقة الجديد ",
                                    1,
                                    controllerMyProfile,
                                    formstate);
                              },
                            );
                            streamSubscriptionNameRing ??= controllerMyProfile
                                .onValueNameRingChanged
                                .listen((event) {
                              ringName = event;
                              SharedBase.editNameRing(ringName!);
                              setState(() {});
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Coloring.secondary,
                                borderRadius: BorderRadius.circular(15)),
                            height: Sizer.getHeight(context) / 4.5,
                            width: Sizer.getWidth(context) / 3,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text("تعديل اسم الحلقة",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              Sizer.getTextSize(context, 20),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Font.fontfamily)),
                                  Icon(
                                    Icons.edit_document,
                                    size: Sizer.getTextSize(context, 25),
                                  ),
                                  Text("$ringName",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize:
                                              Sizer.getTextSize(context, 15),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Font.fontfamily))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Code.makeAlertDelete(
                                  context, acceptInfoForDelete);
                            });
                        streamSubscription ??=
                            acceptInfoForDelete.onValueChanged.listen((event) {
                          if (event) {
                            SharedBase.delete();
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ), (route) => false);
                          }
                        });
                      },
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Sizer.getTextSize(context, 50)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("حذف الحساب ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizer.getTextSize(context, 25),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily)),
                              Image.asset(
                                "${Font.url}deleteuser.png",
                                fit: BoxFit.cover,
                                width: Sizer.getTextSize(context, 60),
                                height: Sizer.getTextSize(context, 60),
                              )
                            ],
                          ),
                        ),
                      ),
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
