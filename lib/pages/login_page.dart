import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:price_pulse/auth_utils/my_form_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final Color c1 = const Color(0xff5da2ff);
  final Color c2 = const Color(0xff5aa0ff);
  final Color c3 = const Color(0xff509dff);
  final Color c4 = const Color(0xff4193ff);
  Map userData = {};

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Offset topRightOffset = const Offset(0.0, 0.0 + 200.0);
    Offset bottomLeftOffset = Offset(-size.width + 200, size.height);

    return Material(
      elevation: 50,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: MyCircle(
                      center: topRightOffset,
                      radius: 150,
                      color: [c1, c2, c3, c4],
                    ),
                  ),
                  CustomPaint(
                    painter: MyCircle(
                      center: bottomLeftOffset,
                      radius: 150,
                      color: [c1, c2, c3, c4],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.45,
                      height: size.height * 0.8,
                      child: ListView(
                        // scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        children: [
                          CarouselSlider(
                            items: [
                              decorationImage(size, "login_back.jpg"),
                              decorationImage(size, "back.png"),
                            ],
                            options: CarouselOptions(
                              height: size.height * .8,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              viewportFraction: 1.0,
                            ),
                          ),
                          // decorationImage(size, _first, "login_back.jpg"),
                          // decorationImage(size, _first, "back.png"),
                        ],
                      ),
                    ),
                    // AnimatedSwitcher(
                    //   duration: const Duration(seconds: 1),

                    //   transitionBuilder:
                    //       (Widget child, Animation<double> animation) {
                    //     return SlideTransition(
                    //       position: Tween<Offset>(
                    //         begin: const Offset(1.0, 0.0),
                    //         end: Offset.zero,
                    //       ).animate(animation),
                    //       child: child,
                    //     );
                    //   },

                    //   //lower of level of control so i wont use it
                    //   // switchInCurve: Curves.decelerate,
                    //   // switchOutCurve: Curves.decelerate,
                    //   // reverseDuration: const Duration(seconds: 1),
                    //   child: _first
                    //       ? MyFormWidget(
                    //           key: const ValueKey('login'),
                    //           first: _first,
                    //           title: 'Login',
                    //           rather: 'Not a member? Slide to Sign Up Instead',
                    //           signUpOrLogin: signUpOrLogin,
                    //         )
                    //       : MyFormWidget(
                    //           key: const ValueKey('signup'),
                    //           first: _first,
                    //           title: 'SignUp',
                    //           rather: 'Already a member? Slide back to Login',
                    //           signUpOrLogin: signUpOrLogin,
                    //         ),
                    // ),
                    SizedBox(
                      width: size.width * 0.45,
                      height: size.height * 0.8,
                      child: CarouselSlider(
                          items: const [
                            MyFormWidget(
                              key: ValueKey('login'),
                              first: true,
                              title: 'Login',
                              rather: 'Not a member? Slide to Sign Up Instead',
                              login: true,
                              // signUpOrLogin: signUpOrLogin,
                            ),
                            MyFormWidget(
                              key: ValueKey('signup'),
                              first: false,
                              title: 'SignUp',
                              rather: 'Already a member? Slide back to Login',
                              login: false,

                              // signUpOrLogin: signUpOrLogin,
                            ),
                          ],
                          options: CarouselOptions(
                            height: size.height * .8,
                            enlargeCenterPage: true,
                            autoPlay: false,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            viewportFraction: 1.0,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container decorationImage(Size size, String assetname) {
  return Container(
    // duration: const Duration(seconds: 3),
    // width: size.width * 0.45,
    // height: size.height * 0.8,
    // clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.transparent),
      image: DecorationImage(
          // opacity: 0.8,
          image: AssetImage('$assetname'),
          fit: BoxFit.fill),
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
    ),
  );
}

Widget design() {
  //make this after the completion of adding firebase or the google_signIn api in the logic
  return Container();
}

class MyCircle extends CustomPainter {
  Offset center;
  double radius;
  List<Color> color;
  Color shadowColor;
  double elevation; // Controls the shadow offset and intensity

  MyCircle({
    required this.center,
    required this.radius,
    required this.color,
    this.shadowColor = const Color(0x80000000),
    this.elevation = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 3; i >= 0; i--) {
      if (i != 0) {
        final shadowPaint = Paint()
          ..color = shadowColor
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, elevation);
        canvas.drawCircle(center + Offset(elevation / 2, elevation / 2),
            radius * (i + 1), shadowPaint);
      }

      final circlePaint = Paint()
        ..color = color[i]
        ..style = PaintingStyle.fill;

      //Drawing main circle
      canvas.drawCircle(center, radius * (i + 1), circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
