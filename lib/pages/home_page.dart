import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:price_pulse/widgets/MyAppBar.dart';
import 'package:price_pulse/pages/product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController query = TextEditingController();
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: MyAppBar(size: size),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage('hello.jpg'))),
              ),
            ),
            ListView(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('Assets/shoe1.jpeg')),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Image(image: AssetImage('Assets/shoe1.jpeg')),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Image(image: AssetImage('Assets/shoe1.jpeg')),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
