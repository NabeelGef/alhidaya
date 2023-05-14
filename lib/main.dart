import 'package:alhidaya/Screen/HomeScreen/home.dart';
import 'package:alhidaya/Screen/SplashScreen/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/home': (context) => HomeScreen() // هون منحط رموز للصفحات اللي بدنا نروح عليها
        });
  }
}
