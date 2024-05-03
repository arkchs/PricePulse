import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:price_pulse/constants.dart';
import 'package:price_pulse/product_page.dart';
import 'package:price_pulse/fade_animation.dart';
import 'package:price_pulse/typing_anim.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController query = TextEditingController();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.1,
        title: titleAppBar(context),
        actions: [
          TextButton.icon(
              onPressed: () => {},
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.red,
              ),
              label: const Text(
                'favorites',
                style: TextStyle(color: Colors.green, fontSize: 20),
              )),
          TextButton.icon(
            onPressed: () => {Navigator.pushNamed(context, 'loginPage')},
            icon: const Icon(
              Icons.login,
              color: Colors.black,
            ),
            label: const Text(
              'LogIn',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Center(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('Assets/back2.jpg'))),
          ),
        ),
        ListView(children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.25,
                ),
                TypingAnimation(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                inputField(context, query),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Center(child: searchButton(context, query.text)),
                SizedBox(
                  height: size.height * 0.25,
                ),
                FadeAnimation(),
                 SizedBox(height: size.height * 0.3),
              ]),
        ]),
      ]),
    );
  }

  Widget titleAppBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: AutoSizeText(
          'Price Pulse',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      );

  Widget searchButton(BuildContext context, String query) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width / 10,
        height: size.height * 0.05,
        child: TextButton(
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductPage(query: query)))
          },
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black)),
          child: AutoSizeText(
            'Search',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget inputField(BuildContext context, TextEditingController query) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width * 0.5,
        child: TextFormField(
          controller: query,
          decoration: InputDecoration(
            label: const Text(
              'Search',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            prefixIcon: const Icon(Icons.search),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.3),
                borderRadius: BorderRadius.all(Radius.circular(9.0))),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 5.0),
              borderRadius: BorderRadius.all(Radius.circular(9.0)),
            ),
            hintStyle: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
