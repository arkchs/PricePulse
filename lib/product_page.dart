import 'package:flutter/material.dart';
import 'package:price_pulse/web_scraping.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.query});
  final String query;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

//product splash animations for making the project look better.
class _ProductPageState extends State<ProductPage> {
  var flipkart;
  var amazon;
  @override
  void initState(){
    super.initState();
  }
  Future<List<String>> _asyncWorkAround() async {
    Web_scraper object= Web_scraper();
    // amazon=await object.getDataAmazon(widget.query);
    flipkart = await object.getDataFlipkart(widget.query);
    print(amazon);
    print(flipkart);
    return [flipkart,(flipkart.toDouble()+100).toString()];
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [productImageCard(context, size)],
            ),
          ),
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
    Future<List<String>>? data=_asyncWorkAround();
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
                child: Text('Result: ${snapshot.data}'),
              ),
            ]; 
          } 
          else if(snapshot.hasError) {
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
            }else {
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
        }
    );
  }
        

  Widget productImageCard(BuildContext context, var size) {
    var _imgsrc = 'Assets/product_sample.jpg';
    return SizedBox(
      height: size.height * 0.7,
      child: Card(
        child: Image(image: AssetImage(_imgsrc), fit: BoxFit.fill),
      ),
    );
  }
        }
