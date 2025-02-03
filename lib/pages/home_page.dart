import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late final AnimationController _controller =
  //     AnimationController(vsync: this, duration: const Duration(seconds: 3))
  //       ..repeat(reverse: true);
  // late final Animation<Offset> _offsetTwoAnimation = Tween<Offset>(
  //   begin: Offset(-1.0, 0.0),
  //   end: Offset.zero,
  // ).animate(CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.easeIn,
  // ));
  // late final Animation<Offset> _offsetThreeAnimation = Tween<Offset>(
  //   begin: Offset(-2.0, 0.0),
  //   end: Offset.zero,
  // ).animate(CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.easeIn,
  // ));

  @override
  Widget build(BuildContext context) {
    TextEditingController query = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text(
          "Price Pulse",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              elevation: const MaterialStatePropertyAll(0.0),
              onTap: () {},
              shape: const MaterialStatePropertyAll(BeveledRectangleBorder()),
              hintText: "Enter the Product Name to search!",
              hintStyle: MaterialStatePropertyAll(
                  Theme.of(context).textTheme.displaySmall),
              textStyle: MaterialStatePropertyAll(
                  Theme.of(context).textTheme.displaySmall),
            ),
          ),
          myButton(() {}, 'Favorites', context),
          myButton(() {
            Navigator.pushNamed(context, 'loginPage');
          }, 'Login', context),
        ],
      ),
      body: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .025),
                child: Container(
                  height: size.height,
                  width: size.width * .05,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          scrollDirection: Axis.vertical,
                          autoPlay: true,
                          viewportFraction: 1.0,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000)),
                      items: [
                        Text(" A \n M \n A \n Z \n O \n N ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary)),
                        Text(" F \n L \n I \n P \n K \n A \n R \n T ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary)),
                        Text(
                            " M \n O \n R \n E \n\n T \n O \n\n C \n O \n M \n E ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary)),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search, Compare, Save",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey),
                    ),
                    Container(
                      width: size.width * .15,
                      height: 1.0,
                      color: Colors.blue,
                    ),
                    Text(
                      "Compare\nPrices",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: size.height * .2,
                    ),
                    Row(
                      children: [
                        customCard(context, "Search",
                            Theme.of(context).colorScheme.primary),
                        customCard(context, "Compare",
                            Theme.of(context).colorScheme.secondary),
                        customCard(context, "Save!",
                            Theme.of(context).colorScheme.tertiary),
                      ],
                    ),
                  ],
                ),
              ),
              divider(size),
              SvgPicture.asset(
                'assets/shopping.svg',
                height: size.height * .75,
                width: size.width * .3,
              )
            ],
          )
        ],
      ),
    );
  }

  Padding divider(size) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: size.height * .05),
      child: Container(
        width: 3.0,
        height: size.height * .7,
        color: Colors.grey,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
      ),
    );
  }

  Container customCard(BuildContext context, title, color) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSecondary)),
      ),
    );
  }

  Widget myButton(onTap, title, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            elevation: MaterialStatePropertyAll(5.0),
            shape: MaterialStatePropertyAll(BeveledRectangleBorder())),
        child: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
