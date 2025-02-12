import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:price_pulse/constants/theme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat(reverse: false);
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool light = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController query = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onTertiary,
        elevation: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
            ? 3.0
            : 10.0,
        shadowColor: Theme.of(context).colorScheme.surface,
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          color: Theme.of(context).colorScheme.tertiary,
          child: Text(
            "Price Pulse",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onTertiary),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              shadowColor: const MaterialStatePropertyAll(Colors.grey),
              backgroundColor: const MaterialStatePropertyAll(Colors.white),
              elevation: const MaterialStatePropertyAll(0.0),
              onTap: () {},
              shape: const MaterialStatePropertyAll(BeveledRectangleBorder()),
              hintText: "Enter the Product Name to search!",
              hintStyle: MaterialStatePropertyAll(Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: Colors.black)),
              textStyle: MaterialStatePropertyAll(Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: Colors.black)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => context.go('/login'),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.tertiary),
                  elevation: const MaterialStatePropertyAll(5.0),
                  shape:
                      const MaterialStatePropertyAll(BeveledRectangleBorder())),
              child: Text(
                'Favorites',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Consumer<ApplicationState>(
          //   builder: (context, appState, _) => AuthFunc(
          //       loggedIn: appState.loggedIn,
          //       signOut: () {
          //         FirebaseAuth.instance.signOut();
          //       }),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => context.go('/login'),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.tertiary),
                  elevation: const MaterialStatePropertyAll(5.0),
                  shape:
                      const MaterialStatePropertyAll(BeveledRectangleBorder())),
              child: Text(
                'Account',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Switch(
            activeColor: Theme.of(context).colorScheme.tertiary,
            activeTrackColor: Theme.of(context).colorScheme.onTertiary,
            inactiveThumbColor: Theme.of(context).colorScheme.tertiary,
            inactiveTrackColor: Theme.of(context).colorScheme.onTertiary,
            value: light,
            onChanged: (value) => {
              setState(() {
                light = !light;
              }),
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              alertsBarVertical(size, context),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
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
                      SizedBox(
                        width: size.width * .05,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 50),
                      //   child: SvgPicture.asset(
                      //     'shopping.svg',
                      //     height: size.height * .75,
                      //     width: size.width * .35,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Lottie.asset(
                          controller: _controller,
                          height: size.height * .7,
                          width: size.width * .3,
                          'sale.json',
                        ),
                        // Lottie.asset(
                        //   controller: _controller,
                        //   height: size.height * .7,
                        //   width: size.width * .3,
                        //   'one.json',
                        // ),
                        // Lottie.asset(
                        //   controller: _controller,
                        //   height: size.height * .7,
                        //   width: size.width * .3,
                        //   'two.json',
                        // ),
                        // Lottie.asset(
                        //   controller: _controller,
                        //   height: size.height * .7,
                        //   width: size.width * .3,
                        //   'three.json',
                        // ),
                        // ],
                        // ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          dividerHorizontal(size),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                controller: _controller,
                height: size.height * .7,
                width: size.width * .3,
                'search.json',
              ),
              Lottie.asset(
                controller: _controller,
                height: size.height * .7,
                width: size.width * .3,
                'trolley.json',
              ),
              Lottie.asset(
                controller: _controller,
                height: size.height * .7,
                width: size.width * .3,
                'pig_save.json',
              ),
            ],
          ),
          dividerHorizontal(size),
          const SizedBox(
            height: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Search for your favorite products'),
              Text('and we will give you the best price across'),
              Text('the internet!'),
            ],
          ),
          dividerHorizontal(size),
          const SizedBox(
            height: 50,
          ),
          Column(
            children: [Text('Found an Error?'), Text('Contact Us please!')],
          )
        ],
      ),
    );
  }

  Column alertsBarVertical(Size size, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .025),
          child: Container(
            height: size.height * 1,
            width: size.width * .05,
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.tertiary),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary)),
                  Text(" F \n L \n I \n P \n K \n A \n R \n T ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary)),
                  Text(" M \n O \n R \n E \n\n T \n O \n\n C \n O \n M \n E ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding divider(size) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: size.height * .1),
      child: Container(
        width: 3.0,
        height: size.height * .7,
        color: Colors.grey,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
      ),
    );
  }

  Padding dividerHorizontal(size) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        width: size.width,
        height: 3.0,
        color: Colors.black,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSecondary)),
        ),
      ),
    );
  }
}
