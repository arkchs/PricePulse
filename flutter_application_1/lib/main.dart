import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_page/login_page.dart';
import 'package:flutter_application_1/product_page.dart';
import 'home_page.dart';
import 'constants/constants.dart';
void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/':(context) => HomePage(),
        'loginPage':(context) => Login(),
        'productPage':(context) => ProductPage(),
      },
      theme: themeData
    );
  }
}