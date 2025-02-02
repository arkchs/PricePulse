import 'package:flutter/material.dart';
import 'package:price_pulse/constants/theme.dart';
import 'package:price_pulse/login/login_page.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
  ], child: const MyApp()));
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
      color: Colors.white,
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
