import 'package:alhidaya/Model/sharedbase.dart';
import 'package:alhidaya/Screen/AddStudent/add_student.dart';
import 'package:alhidaya/Screen/AdultScreen/adult.dart';
import 'package:alhidaya/Screen/LoginScreen/login.dart';
import 'package:alhidaya/Screen/MyProfile/myprofile.dart';
import 'package:alhidaya/Screen/ShowStudent/show_students.dart';
import 'package:alhidaya/Screen/SplashScreen/splash.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'Model/databasehelper.dart';

final dbHelper = DataBaseHelper();
final getIt = GetIt.asNewInstance();
late Map<String, String?> data;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  data = await SharedBase.getUserData();
  await dbHelper.init();
  registerServices();
  runApp(const MyApp());
}

void registerServices() {
  getIt.registerSingleton<DataBaseHelper>(dbHelper);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //locale: DevicePreview.locale(context),
        // builder: (context, child) {
        //   ResponsiveWrapper.builder(
        //     ClampingScrollWrapper.builder(context, child!),
        //     maxWidth: 1200,
        //     minWidth: 480,
        //     defaultScale: true,
        //     breakpoints: [
        //       ResponsiveBreakpoint.autoScale(480, name: 'SM'),
        //       ResponsiveBreakpoint.autoScale(800, name: 'MD'),
        //       ResponsiveBreakpoint.autoScale(1000, name: 'LG'),
        //       ResponsiveBreakpoint.autoScale(1200, name: 'XL'),
        //       ResponsiveBreakpoint.autoScale(2460, name: '2K'),
        //     ],
        //   );
        //   return DevicePreview.appBuilder(context, child);
        // },
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Splash(),
          '/login': (context) =>
              const LoginScreen(), // هون منحط رموز للصفحات اللي بدنا نروح عليها
          '/adult': (context) => const AdultScreen(),
          '/addstudent': (context) => AddStudent(),
          '/showstudent': (context) => ShowStudent(),
          '/myprofile': (context) => MyProfile()
        });
  }
}
