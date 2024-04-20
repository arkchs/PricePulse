
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}
//product splash animations for making the project look better.
class _ProductPageState extends State<ProductPage> {
  final _imgsrc = 'Assets/product_sample.jpg';
  // final List<String> _url=[];
  // final List<String> _productTitle=[];
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width*0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [productImageCard(context, size)],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: size.width*0.5,
              height: size.height*0.2,
              child: priceCards(context,size),
            ),
          )
        ],
      ),
    );
  }

  Widget priceCards(BuildContext context, var size) {
    return ListView.builder(
      itemCount: companyList.length,
      itemBuilder: (context, index){
        final item=companyList[index];
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 10.0,
            color: Colors.black,
            child: Text(item,style: Theme.of(context).textTheme.headlineLarge,),
          ),
        );
        return null;
      },
      
    );
  }

  Widget productTitle(String productTitle) {
    return AutoSizeText(productTitle);
  }


  Widget productImageCard(BuildContext context, var size) {
    return SizedBox(
      height: size.height * 0.7,
      child: Card(
        child: Image(image: AssetImage(_imgsrc), fit: BoxFit.fill),
      ),
    );
  }
}
