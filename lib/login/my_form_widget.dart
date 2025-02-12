import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:price_pulse/utils/authentication.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyFormWidget extends StatefulWidget {
  // final Function() signUpOrLogin;
  final String rather;
  final String title;
  final bool first;
  const MyFormWidget(
      {super.key,
      // required this.signUpOrLogin,
      required this.rather,
      required this.title,
      required this.first});

  @override
  State<MyFormWidget> createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController textControllerEmail = TextEditingController();
  final TextEditingController textControllerPassword = TextEditingController();
  final TextEditingController textControllerUsername = TextEditingController();
  final Radius circleRadius = const Radius.circular(20);
  Color primary = const Color(0xff86b8ff);
  Color textColor = const Color(0xff010b6c);

  void googleOnTap() {
    final snackBar = SnackBar(
      content: const Text('Yay! A Google SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void facebookOnTap() {
    final snackBar = SnackBar(
      content: const Text('Yay! A Facebook SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void xOnTap() {
    final snackBar = SnackBar(
      content: const Text('Yay! A Twitter SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.45,
      height: size.height * 0.8,
      decoration: BoxDecoration(
        // color: Colors.white.withOpacity(0.8),
        color: Theme.of(context).colorScheme.onTertiary,
        // backgroundBlendMode: BlendMode.srcOver,
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.only(
            topRight: circleRadius, bottomRight: circleRadius),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 10,
        //     spreadRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      padding: const EdgeInsets.fromLTRB(100, 100, 100, 12),
      // margin: const EdgeInsets.all(20),
      child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.0,
                        color: textColor),
                  ),
                ),
                Text(
                  "Please ${widget.title} to continue",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                      color: textColor),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                if (!widget.first)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: myTextField(
                      textControllerUsername,
                      'Username',
                      MultiValidator([
                        RequiredValidator(errorText: 'Enter a Username'),
                        MinLengthValidator(8,
                            errorText: 'Password must be atleast 8 digit'),
                        PatternValidator(r'(?=.*?[#!@$%^&*-])',
                            errorText:
                                'Password must contain atleast one special character')
                      ]),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: myTextField(
                    textControllerEmail,
                    'Email',
                    MultiValidator([
                      RequiredValidator(errorText: 'Enter email address'),
                      EmailValidator(errorText: 'Please Enter a Valid E-mail'),
                    ]),
                  ),
                ),
                myTextField(
                  textControllerPassword,
                  'Password',
                  MultiValidator([
                    RequiredValidator(errorText: 'Enter your Password'),
                    MinLengthValidator(8,
                        errorText: 'Password must be atleast 8 digit'),
                    PatternValidator(r'(?=.*?[#!@$%^&*-])',
                        errorText:
                            'Password must contain atleast one special character')
                  ]),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: MyButton(
                      text: widget.title,
                      formkey: _formkey,
                      textControllerEmail: textControllerEmail,
                      textControllerPassword: textControllerPassword),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  signIn(googleOnTap, 'google'),
                  const SizedBox(
                    width: 30,
                  ),
                  signIn(facebookOnTap, 'facebook'),
                  const SizedBox(
                    width: 30,
                  ),
                  signIn(xOnTap, 'x'),
                ]),
                const SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // widget.signUpOrLogin();
                    },
                    child: Text(widget.rather),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
              ]),
        ),
      ),
    );
  }

  Widget signIn(onTap, svgimage) {
    return SizedBox(
      height: 40,
      width: 40,
      child: GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          'assets/$svgimage.svg',
          // colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        ),
      ),
    );
  }

//Implementation of the sign up button.
  Widget myTextField(TextEditingController textController, String title,
      MultiValidator validator) {
    return TextFormField(
      validator: validator.call,
      style: Theme.of(context).textTheme.displaySmall,
      controller: textController,
      decoration: InputDecoration(
        hintText: title,
        labelText: title,
        labelStyle: Theme.of(context).textTheme.displaySmall,
        hintStyle: Theme.of(context).textTheme.displaySmall,
        prefixIcon: Icon(
          Icons.account_circle_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        errorStyle: const TextStyle(fontSize: 18.0),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  final String text;
  final GlobalKey<FormState> formkey;
  final TextEditingController textControllerEmail;
  final TextEditingController textControllerPassword;
  final TextEditingController? textControllerUsername;
  const MyButton(
      {super.key,
      required this.text,
      required this.formkey,
      this.textControllerUsername,
      required this.textControllerEmail,
      required this.textControllerPassword});

  @override
  State<MyButton> createState() => _MyButtonState();
}

// TODO: Add the firebase client to implement this logic
class _MyButtonState extends State<MyButton> {
  void login() async {
    print("login works");
    if (widget.formkey.currentState!.validate()) {
      setState(() {});
      await signInWithEmailPassword(widget.textControllerEmail.text,
              widget.textControllerPassword.text)
          .then((result) {
        print(result);
        context.go('/');
      }).catchError((error) {
        print('Login Error: $error');
      });
    }
  }

  void signin() async {
    if (widget.formkey.currentState!.validate()) {
      setState(() {});
      await registerWithEmailPassword(widget.textControllerEmail.text,
              widget.textControllerPassword.text)
          .then((result) {
        //print(result);
        context.go('/');
      }).catchError((error) {
        //print('Login Error: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.18,
      height: 50,
      child: TextButton(
        onPressed: () {
          login();
        },
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.blueAccent),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)))),
        child: Text(
          widget.text,
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
