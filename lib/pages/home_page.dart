import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController query = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.white,
        title: Container(
            color: Theme.of(context).colorScheme.primary,
            child: Text(
              "Price Pulse",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
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
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * .05, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search, Compare, Save",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                ),
                Text(
                  "Price",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "Compare",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
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
