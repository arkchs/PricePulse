import 'package:flutter/material.dart';
import 'package:price_pulse/login/login_page.dart';
import 'home_page.dart';
import 'constants.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomePage(),
          'loginPage': (context) => const Login(),
        },
        theme: themeData);
  }
}
