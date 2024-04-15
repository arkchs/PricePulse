import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_page/form_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map userData = {};
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      elevation: 50,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(242, 223, 205, 1),
        body:  Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
              decorationImage(size),
              Positioned(right: 0,child: Form_widget()),
            ]),
          ),
        ),
    );
  }

  Container decorationImage(Size size) {
    return Container( 
      width: size.width * 0.9,
      height: size.height * 0.8,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        image: const DecorationImage(
            image: AssetImage('Assets/login_image.jpg'), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget design() {
    //make this after the completion of adding firebase or the google_signIn api in the logic
    return Container();
  }
}
