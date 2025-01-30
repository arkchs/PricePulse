import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:price_pulse/utils/authentication.dart';

class MyFormWidget extends StatefulWidget {
  final Function() signUpOrLogin;
  final String rather;
  final String title;
  const MyFormWidget(
      {super.key,
      required this.signUpOrLogin,
      required this.rather,
      required this.title});

  @override
  State<MyFormWidget> createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController textEmailController = TextEditingController();
  final TextEditingController textControllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * 0.45,
        height: size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.fromLTRB(12, 100, 20, 12),
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                emailTextField(textEmailController),
                passwordTextField(textControllerPassword),
                MyButton(
                    text: widget.title,
                    formkey: _formkey,
                    textEmailController: textEmailController,
                    textControllerPassword: textControllerPassword),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        facebookSignIn(size),
                        const SizedBox(
                          width: 15,
                        ),
                        googleSignIn(size),
                        const SizedBox(
                          width: 15,
                        ),
                        twitterSignIn(size),
                      ]),
                ),
                TextButton(
                  onPressed: () {
                    widget.signUpOrLogin();
                  },
                  child: Text(widget.rather),
                ),
              ]),
        ),
      ),
    );
  }

//Imlementation for the google sign in button
  Widget googleSignIn(var size) {
    return SizedBox(
      height: 100,
      width: 100,
      child: ElevatedButton(
        clipBehavior: Clip.antiAlias,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onPressed: () async => {},
        child: const Image(
          image: AssetImage('Assets/google.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

//Implementation of the facebook sign in button
  Widget facebookSignIn(var size) {
    return SizedBox(
      height: 100,
      width: 100,
      child: ElevatedButton(
          clipBehavior: Clip.antiAlias,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          onPressed: () => {},
          child: const Image(image: AssetImage('Assets/Instagram.jpg'))),
    );
  }

  Widget twitterSignIn(var size) {
    return SizedBox(
      height: 100,
      width: 100,
      child: ElevatedButton(
        clipBehavior: Clip.antiAlias,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onPressed: () => {},
        child: const Image(image: AssetImage('Assets/Twitter.jpg')),
      ),
    );
  }

//Implementation of the sign up button.
  Widget emailTextField(textEmailController) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
            controller: textEmailController,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Enter email address'),
              EmailValidator(errorText: 'Please Enter a Valid E-mail'),
            ]),
            decoration: const InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.green,
                ),
                errorStyle: TextStyle(fontSize: 18.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(9.0))))));
  }

  Widget passwordTextField(textControllerPassword) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: textControllerPassword,
        validator: MultiValidator([
          RequiredValidator(errorText: 'Enter your Password'),
          MinLengthValidator(8, errorText: 'Password must be atleast 8 digit'),
          PatternValidator(r'(?=.*?[#!@$%^&*-])',
              errorText: 'Password must contain atleast one special character')
        ]),
        decoration: const InputDecoration(
          hintText: 'Password',
          labelText: 'Password',
          prefixIcon: Icon(
            Icons.key,
            color: Colors.green,
          ),
          errorStyle: TextStyle(fontSize: 18.0),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(9.0))),
        ),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  final String text;
  final GlobalKey<FormState> formkey;
  final TextEditingController textEmailController;
  final TextEditingController textControllerPassword;
  const MyButton(
      {super.key,
      required this.text,
      required this.formkey,
      required this.textEmailController,
      required this.textControllerPassword});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.18,
      height: 50,
      child: TextButton(
        onPressed: () async {
          if (widget.formkey.currentState!.validate()) {
            setState(() {});
            await registerWithEmailPassword(widget.textEmailController.text,
                    widget.textControllerPassword.text)
                .then((result) {
              //print(result);
            }).catchError((error) {
              //print('Login Error: $error');
            });
          }
        },
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.blueAccent),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)))),
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
