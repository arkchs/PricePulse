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
              icon: const Icon(Icons.abc),
              label: const Text('LogIn')),
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
              inputField(context, query),
              SizedBox(
                height: size.height * 0.02,
              ),
              Center(child: searchButton(context, query.text)),
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
          const Icon(
            Icons.shopping_cart,
            size: 100,
          ),
        ],
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
                borderSide: BorderSide(color: Colors.black,width: 5.0),
                borderRadius: BorderRadius.all(Radius.circular(9.0)),),
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
