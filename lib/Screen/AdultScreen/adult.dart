import 'package:alhidaya/Constant/color.dart';
import 'package:alhidaya/Constant/sizer.dart';
import 'package:alhidaya/main.dart';
import 'package:flutter/material.dart';

import '../../Constant/code.dart';
import '../../Constant/font.dart';

class AdultScreen extends StatefulWidget {
  const AdultScreen({super.key});

  @override
  State<AdultScreen> createState() => _AdultScreenState();
}

class _AdultScreenState extends State<AdultScreen> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  void initState() {
    print("DATA NAME : ${data['name']}");
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
          appBar: Code.getAppBar(context, scaffoldState, "دورة الناشئة"),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/addstudent');
                      },
                      child: Container(
                        width: Sizer.getWidth(context) / 1.1,
                        decoration: BoxDecoration(
                            color: Coloring.primary,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Image.asset("${Font.url}addstudent.png"),
                            Text(
                              "إضافة طالب",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizer.getTextSize(context, 25)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/showstudent');
                      },
                      child: Container(
                        width: Sizer.getWidth(context) / 1.1,
                        decoration: BoxDecoration(
                            color: Coloring.primary,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Image.asset("${Font.url}students.png"),
                            Text(
                              "عرض الطلاب",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizer.getTextSize(context, 25)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
