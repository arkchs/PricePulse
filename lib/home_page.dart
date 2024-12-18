import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:price_pulse/product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController query = TextEditingController();
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // centerTitle: true,
          toolbarHeight: size.height * 0.07,
          title: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle, color: Color(0xffd335c6)),
            child: Text(
              'Price Pulse',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 1,
            ),
          ),
          actions: [
            SearchBar(
              elevation: const MaterialStatePropertyAll(0),
              hintText: "Enter The Product Name",
              hintStyle: MaterialStatePropertyAll(TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
              padding:
                  const MaterialStatePropertyAll(EdgeInsets.only(left: 10.0)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
            ),
            IconButton(
              onPressed: () => {},
              icon: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffd335c6)),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
              // label: Container(
              //   padding: const EdgeInsets.all(3.0),
              //   decoration: const BoxDecoration(
              //       shape: BoxShape.circle, color: Color(0xffd335c6)),
              //   child: Text(
              //     'favorite',
              //     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              //         fontWeight: FontWeight.bold, color: Colors.white),
              //     maxLines: 1,
              //   ),
              // ),
            ),
            IconButton(
              onPressed: () => {Navigator.pushNamed(context, 'loginPage')},
              icon: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffd335c6)),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
              ),
              // label: Container(
              //   padding: const EdgeInsets.all(3.0),
              //   decoration: const BoxDecoration(
              //       shape: BoxShape.rectangle, color: Color(0xffd335c6)),
              //   child: Text(
              //     'Login',
              //     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              //         fontWeight: FontWeight.bold, color: Colors.white),
              //     maxLines: 1,
              //   ),
              // ),
            ),
          ],
        ),
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
                    Image(image: AssetImage('shoe1.jpeg')),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Image(image: AssetImage('shoe1.jpeg')),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Image(image: AssetImage('shoe1.jpeg')),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
