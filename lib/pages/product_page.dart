import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  @override
  void initState() {
    super.initState();
    // _asyncWorkAround();
  }

  Future<String> fetchScrapedDataFlipkart() async {
    final url =
        Uri.parse("http://localhost:5000/scrape?url=https://example.com");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      } else {
        print("Failed to scrape: ${response.body}");
        return 'Failed to scrape';
      }
    } catch (e) {
      print("Error: $e");
      return 'Failed to scrape';
    }
  }

  Future<String> fetchScrapedDataAmazon() async {
    final url = Uri.parse(
        "http://localhost:5000/scrape-amazon?url=https://example.com");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      } else {
        print("Failed to scrape: ${response.body}");
        return 'Failed to scrape';
      }
    } catch (e) {
      print("Error: $e");

      return 'Failed to scrape';
    }
  }

  Future<List<String>> _asyncWorkAround() async {
    final String flipkartPrices = await fetchScrapedDataFlipkart();
    final String amazonPrices = await fetchScrapedDataAmazon();
    // flipkartPrices.addAll(amazonPrices);
    return [flipkartPrices, amazonPrices];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(
          //   width: size.width * 0.5,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [productImageCard(context, size)],
          //   ),
          // ),
          Expanded(
            child: SizedBox(
              width: size.width * 0.3,
              height: size.height * 0.5,
              child: priceCards(context, size),
            ),
          )
        ],
      ),
    );
  }

  Widget priceCards(BuildContext context, var size) {
    Future<List<String>> data = _asyncWorkAround();
    return FutureBuilder<List<String>>(
        future: data, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Result: ${snapshot.data?[0]}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Result: ${snapshot.data?[1]}'),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          );
        });
  }

  Widget productImageCard(BuildContext context, var size) {
    var imgsrc = 'assets/product_sample.jpg';
    return SizedBox(
      height: size.height * 0.7,
      child: Card(
        child: Image(image: AssetImage(imgsrc), fit: BoxFit.fill),
      ),
    );
  }
}
