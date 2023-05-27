import 'package:alhidaya/Constant/color.dart';
import 'package:alhidaya/Constant/sizer.dart';
import 'package:alhidaya/Model/sharedbase.dart';
import 'package:flutter/material.dart';

import '../../Constant/font.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerNumPhone = TextEditingController();
  TextEditingController controllerNameRing = TextEditingController();
  TextEditingController controllerNumRing = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(Font.url + "background.png"),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: Sizer.getHeight(context) / 6),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          height: Sizer.getHeight(context) / 2.5,
                          width: Sizer.getWidth(context) / 1.1,
                          decoration: BoxDecoration(
                            color: Coloring.primary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            '  \n السّلام عليكم ورحمة الله تعالى وبركاته\n\n '
                            '  أهلاً وسهلاً بكم في تطبيق مسجد الهداية يرجى من الإخوة المشرفين الكرام \n : تعبئة المعلومات المطلوبة  ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Sizer.getTextSize(context, 15),
                              fontFamily: Font.fontfamily,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: Sizer.getHeight(context) / 50,
                              ),
                              MakeTextFormField(controllerName,
                                  TextInputType.text, 'الإسم و الكنية', 30),
                              SizedBox(
                                height: Sizer.getHeight(context) / 50,
                              ),
                              MakeTextFormField(controllerNumPhone,
                                  TextInputType.number, 'رقم الموبايل', 10),
                              SizedBox(
                                height: Sizer.getHeight(context) / 50,
                              ),
                              MakeTextFormField(controllerNameRing,
                                  TextInputType.text, 'اسم الحلقة', 30),
                              SizedBox(
                                height: Sizer.getHeight(context) / 50,
                              ),
                              MakeTextFormField(controllerNumRing,
                                  TextInputType.number, 'رقم الحلقة', 3),
                              SizedBox(
                                height: Sizer.getHeight(context) / 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      MaterialButton(
                          elevation: 5,
                          color: Coloring.primary,
                          minWidth: Sizer.getWidth(context) / 1.1,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              data = await SharedBase.saveUserData(
                                controllerName.text,
                                controllerNumPhone.text,
                                controllerNameRing.text,
                                controllerNumRing.text,
                              );
                              Navigator.pushReplacementNamed(context, "/adult");
                            } else {
                              print("Failure");
                            }
                          },
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                                fontFamily: Font.fontfamily,
                                color: Colors.black,
                                fontSize: Sizer.getTextSize(context, 25),
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: Sizer.getHeight(context) / 10,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    '${Font.url}alhidaya.png',
                    width: Sizer.getWidth(context) / 2.8,
                    height: Sizer.getHeight(context) / 2.8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  MakeTextFormField(TextEditingController controller, TextInputType type,
      String labelText, int length) {
    return TextFormField(
      maxLength: length,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "يجب ملئ الحقل ";
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
              color: Coloring.secondary,
              fontFamily: Font.fontfamily,
              fontSize: Sizer.getTextSize(context, 15),
              fontWeight: FontWeight.bold),
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
          hintText: labelText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: Font.fontfamily,
            fontSize: Sizer.getTextSize(context, 15),
          ),
          hintTextDirection: TextDirection.rtl,
          fillColor: Coloring.secondary,
          filled: true),
    );
  }
}
