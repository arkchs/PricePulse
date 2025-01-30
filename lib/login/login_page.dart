import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:price_pulse/login/my_form_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  final Color c1 = const Color(0xff5da2ff);
  final Color c2 = const Color(0xff5aa0ff);
  final Color c3 = const Color(0xff509dff);
  final Color c4 = const Color(0xff4193ff);
  bool _first = true;
  Map userData = {};

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimationImage = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastEaseInToSlowEaseOut,
  ));

  late final Animation<Offset> _offsetAnimationCard = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastEaseInToSlowEaseOut,
  ));
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void signUpOrLogin() {
    setState(() {
      _first ? _controller.forward() : _controller.reverse();
      _first = !_first;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Offset topRightOffset = Offset.zero;
    Offset bottomLeftOffset = Offset(-size.width, size.height);

    return Material(
      elevation: 50,
      child: Scaffold(
        backgroundColor: const Color(0xff2281ff),
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
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                SlideTransition(
                    position: _offsetAnimationImage,
                    child: decorationImage(size, _first)),
                AnimatedSwitcher(
                  duration: const Duration(seconds: 3),
                  child: _first
                      ? SlideTransition(
                          position: _first
                              ? _offsetAnimationCard
                              : _offsetAnimationImage,
                          child: MyFormWidget(
                            title: 'Login',
                            rather: 'Not a member? Sign Up',
                            signUpOrLogin: signUpOrLogin,
                          ),
                        )
                      : SlideTransition(
                          position: _first
                              ? _offsetAnimationImage
                              : _offsetAnimationCard,
                          child: MyFormWidget(
                            title: 'SignUp',
                            rather: 'Already a member? Login',
                            signUpOrLogin: signUpOrLogin,
                          ),
                        ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer decorationImage(Size size, bool _first) {
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      curve: Curves.easeIn,
      width: size.width * 0.45,
      height: size.height * 0.8,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        image: const DecorationImage(
            image: AssetImage('Assets/login.png'), fit: BoxFit.fill),
        borderRadius: _first
            ? const BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
            : const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
      ),
    );
  }

  Widget design() {
    //make this after the completion of adding firebase or the google_signIn api in the logic
    return Container();
  }
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
    this.shadowColor =
        const Color(0x80000000), // Semi-transparent black for shadow
    this.elevation = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 3; i >= 0; i--) {
      // Draw shadow (slightly offset from the circle)
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

      // Draw main circle
      canvas.drawCircle(center, radius * (i + 1), circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // Return true if repainting is necessary
  }
}
