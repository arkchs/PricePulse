import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.1,
        title: titleAppBar(context),
        actions: [
          TextButton.icon(
              onPressed: () => {},
              icon: const Icon(Icons.abc),
              label: const Text(
                'favorites',
              )),
          TextButton.icon(
              onPressed: () => {Navigator.pushNamed(context, 'loginPage')},
              icon: const  Icon(Icons.abc),
              label: const  Text('LogIn')),
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
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title(context),
              SizedBox(
                height: size.height * 0.05,
              ),
              inputField(context),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [searchButton(context), searchButton(context)],
              ),
            ]),
      ]),
    );
  }

  Widget titleAppBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: AutoSizeText(
          'Price Compare Pro',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      );

  Widget title(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              'Let\'s Compare!',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                  ),
              maxLines: 1,
            ),
          ),
          Icon(
            Icons.shopping_cart,
            size: 100,
          ),
        ],
      );

  Widget searchButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width / 10,
        height: size.height * 0.05,
        child: TextButton(
          onPressed: () => {Navigator.pushNamed(context, 'productPage')},
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black)
          ),
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

  Widget inputField(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * 0.5,
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Enter the item to be searched',
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
