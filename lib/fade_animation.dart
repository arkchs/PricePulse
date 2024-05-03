import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:price_pulse/constants.dart';

class FadeAnimation extends StatefulWidget {
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curve;

  @override
  initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FadeTransition(
        opacity: _curve,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              height: size.height * 0.6,
              width: size.width * 0.3,
              child: CustomCard(title: 'Electronics')),
          SizedBox(
              height: size.height * 0.6,
              width: size.width * 0.3,
              child: CustomCard(title: 'Fashion')),
          SizedBox(
              height: size.height * 0.6,
              width: size.width * 0.3,
              child: CustomCard(title: 'Grocery')),
        ]),
      ),
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// class TypewriterTween extends Tween<String> {
//   TypewriterTween({String begin = '', String end})
//       : super(begin: begin, end: end);

//   @override
//   String lerp(double t) => end.substring(0, (t * end.length).round());
// }

// class Headline extends AnimatedWidget {
//   Headline({Key key, Animation<String> animation})
//       : super(key: key, listenable: animation);

//   @override
//   Widget build(BuildContext context) {
//     final Animation<String> animation = listenable;
//     return Text(animation.value, style: TextStyle(fontSize: 35.0));
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     controller?.dispose();
//   }
// }
