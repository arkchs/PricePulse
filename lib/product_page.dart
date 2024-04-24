
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:price_pulse/web_scraping.dart';
import 'constants.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.query});
  final String query;
  @override
  State<ProductPage> createState() => _ProductPageState();
}
//product splash animations for making the project look better.
class _ProductPageState extends State<ProductPage> {
  void getTitleAndPrice()
  {
      Web_scraper(widget.query);
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
              height: size.height*0.5,
              child: priceCards(context,size),
            ),
          )
        ],
      ),
    );
  }

  Widget priceCards(BuildContext context, var size) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: companyList.length,
      itemBuilder: (context, index){
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: ImageIcon(AssetImage('Assets/${companyList[index].toLowerCase()}.jpg'),),
                contentPadding: EdgeInsets.all(10),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                tileColor: Theme.of(context).colorScheme.primary,
                title: Text(companyList[index]),
                subtitle: Text(Web_scraper(widget.query).getAmazon(widget.query).first),
                onTap: ()=>{
                  // Navigator.pushNamed(context, gamePage[index])
                },
              ),
            ),
          );
      },
      
    );
  }

  Widget productTitle(String productTitle) {
    return AutoSizeText(productTitle);
  }


  Widget productImageCard(BuildContext context, var size) {
    var response= Web_scraper(widget.query).getFlipkart(widget.query);
    var _imgsrc=response.first;
    return SizedBox(
      height: size.height * 0.7,
      child: Card(
        child: Image(image: AssetImage(_imgsrc), fit: BoxFit.fill),
      ),
    );
  }
}


