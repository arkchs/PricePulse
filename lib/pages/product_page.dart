import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:price_pulse/constants/theme.dart';
import 'package:price_pulse/models/product.dart';
import 'package:price_pulse/utils/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.query});
  final String query;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

//product splash animations for making the project look better.
class _ProductPageState extends State<ProductPage> {
  String? flipkart;
  String? amazon;

  Future<List<String>> fetchScrapedDataFlipkart(String query) async {
    final url = Uri.parse("http://localhost:5000/scrape?q=$query");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        List<String> output = data.substring(1, data.length - 1).split(", ");
        return output;
      } else {
        debugPrint("Failed to scrape from Flipkart: ${response.body}");
        return ['Failed to scrape from Flipkart'];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return ['Failed to scrape'];
    }
  }

  Future<List<Product>> fetchScrapedDataAmazon(String query) async {
    final url = Uri.parse("http://localhost:5000/scrape-amazon?q=$query");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final price = jsonDecode(response.body)["data"];
        final imageLink = jsonDecode(response.body)["imageLink"];
        // debugPrint("title: $query");
        // debugPrint("title: $imageLink");
        // debugPrint("title: $title");
        List<String> outputPrice =
            price.substring(1, price.length - 1).split(", ");
        List<String> outputLinks =
            imageLink.substring(1, imageLink.length - 1).split(", ");
        List<Product> output = [];
        int count = min(outputPrice.length, 5);
        for (int i = 0; i < count; i++) {
          output.add(Product(
              name: query, imageLink: outputLinks[i], price: outputPrice[i]));
        }
        return output;
      } else {
        debugPrint("Failed to scrape from Amazon: ${response.body}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");

      return [];
    }
  }

  Future<List<Product>> _asyncWorkAround(String query) async {
    // final List<String> flipkartPrices = await fetchScrapedDataFlipkart(query);
    final List<Product> amazonPrices = await fetchScrapedDataAmazon(query);
    // flipkartPrices.addAll(amazonPrices);
    return amazonPrices;
  }

  @override
  Widget build(BuildContext context) {
    bool dark = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onTertiary,
        elevation: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
            ? 3.0
            : 10.0,
        shadowColor: Theme.of(context).colorScheme.surface,
        // leading: SizedBox(),
        // leadingWidth: 0.0,
        title: GestureDetector(
          onTap: () => context.goNamed('home'),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            color: Theme.of(context).colorScheme.tertiary,
            child: Text(
              "Price Pulse",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onTertiary),
            ),
          ),
        ),
        actions: [
          AppBarButton(
              title: 'Favorites',
              onPressed: () => context.goNamed('favorites',
                  pathParameters: {'userId': 'random-token'})),
          AppBarButton(title: 'Account', onPressed: () => context.go('/login')),
          Switch(
            activeColor: Theme.of(context).colorScheme.tertiary,
            activeTrackColor: Theme.of(context).colorScheme.onTertiary,
            inactiveThumbColor: Theme.of(context).colorScheme.tertiary,
            inactiveTrackColor: Theme.of(context).colorScheme.onTertiary,
            value: dark,
            onChanged: (value) => {
              setState(() {
                dark = !dark;
              }),
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
            },
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AlertsBarVertical(),
            Expanded(
              child: SizedBox(
                width: size.width * 1,
                height: size.height * 1,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: priceCards(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget priceCards() {
    // List<String> hardCoded = [
    //   '1000',
    //   '4000',
    //   '1000',
    //   '4000',
    //   '1000',
    //   '4000',
    //   '1000',
    //   '4000',
    //   '1000',
    //   '4000',
    // ];
    Future<List<Product>> data = _asyncWorkAround(widget.query);
    // return GridView.count(
    //     childAspectRatio: 1 / 1.5,
    //     primary: false,
    //     padding: const EdgeInsets.all(20),
    //     crossAxisSpacing: 60,
    //     mainAxisSpacing: 20,
    //     crossAxisCount: 4,
    //     children: <Widget>[
    //       for (var entry in hardCoded)
    //         customCard(
    //             widget.query,
    //             entry,
    //             'https://m.media-amazon.com/images/I/41lArSiD5hL._AC_UY218_.jpg',
    //             'amazon')
    //     ]);
    return FutureBuilder<List<Product>>(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            List<Product> priceData = snapshot.data!;
            child = GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 4,
                children: <Widget>[
                  for (var entry in priceData)
                    customCard(entry.getName, entry.getPrice,
                        entry.getImageLink, 'amazon')
                ]);
          } else if (snapshot.hasError) {
            child = Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            child = Column(
              children: const [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ],
            );
          }
          return child;
        });
  }

  GestureDetector customCard(title, subtitle, imageLink, website) {
    return GestureDetector(
      onTap: () {
        String link = '';
        switch (website) {
          case 'amazon':
            {
              link = 'https://www.amazon.in/s?k=$title';
            }
            break;
          case 'flipkart':
            {
              link = 'https://www.flipkart.com/search?q=$title';
            }
            break;
          default:
            {
              link = 'https://www.amazon.in/s?k=$title';
            }
            break;
        }
        if (link.isNotEmpty) js.context.callMethod('open', [link]);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.surface,
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                imageLink,
                width: 300,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        '₹$subtitle',
                        style: TextStyle(
                            fontSize: 26.0,
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      SizedBox(height: 4.0),
                    ],
                  ),
                  Text(
                    website,
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 4.0),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
