import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:price_pulse/constants/theme.dart';
import 'package:price_pulse/utils/widgets.dart';
import 'package:provider/provider.dart';

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

  Future<List<String>> fetchScrapedDataAmazon(String query) async {
    final url = Uri.parse("http://localhost:5000/scrape-amazon?q=$query");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        List<String> output = data.substring(1, data.length - 1).split(", ");
        return output;
      } else {
        debugPrint("Failed to scrape from Amazon: ${response.body}");
        return ['Failed to scrape from Amazon'];
      }
    } catch (e) {
      debugPrint("Error: $e");

      return ['Failed to scrape'];
    }
  }

  Future<List<String>> _asyncWorkAround(String query) async {
    // final List<String> flipkartPrices = await fetchScrapedDataFlipkart(query);
    final List<String> amazonPrices = await fetchScrapedDataAmazon(query);
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
        leading: SizedBox(),
        leadingWidth: 0.0,
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
            alertsBarVertical(size, context),
            Expanded(
              child: SizedBox(
                width: size.width * 1,
                height: size.height * 1,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: priceCards('ch520',
                      'https://picsum.photos/700/700?random=10', '5000'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column alertsBarVertical(Size size, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .008),
          child: Container(
            height: size.height * 1,
            width: size.width * 0.09,
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.tertiary),
          ),
        ),
      ],
    );
  }

  Widget priceCards(String title, String imageLink, String price) {
    List<String> hardCoded = [
      'ch520',
      'ch520',
      'ch520',
      'ch520',
      'ch520',
      'ch520',
      'ch520',
      'ch520',
      'ch520'
    ];
    Future<List<String>> data = _asyncWorkAround(widget.query);
    return FutureBuilder<List<String>>(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            List<String> priceData = snapshot.data!;
            child = GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 4,
                children: <Widget>[
                  for (int i = 0; i < priceData.length; i++)
                    customCard(hardCoded[0], priceData[i], imageLink)
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

  Container customCard(title, subtitle, imageLink) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageLink,
                width: 300,
                height: 300,
                fit: BoxFit.fill,
              )),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
