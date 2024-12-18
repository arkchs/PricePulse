import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart' as dom;

class Web_scraper {
  Future<String> getDataAmazon(String query) async {
    Map<String, String> reqHeader = {
      "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36",
      "Accept":
          "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
      "Accept-Language": "en-US,en;q=0.5",
      "Accept-Encoding": "gzip, deflate, br",
      "Referer": "https://www.google.com/",
      "DNT": "1",
      "Connection": "keep-alive",
      "Upgrade-Insecure-Requests": "1",
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
    var url = 'https://www.amazon.in/s?k=';
    url = url + query;
    var response = await http.get(Uri.parse(url), headers: reqHeader);
    // while (response.statusCode != 200) {
    //   response = await http.get(Uri.parse(url), headers: reqHeader);
    //   print('retrying... ${response.statusCode}');
    // }
    // print(response.statusCode);
    dom.Document html = dom.Document.html(response.body);
    final List<String> priceList = html
        .querySelectorAll('span.a-price-whole')
        .map((element) => element.text)
        .toList();
    String price = priceList.elementAt(0);
    // print('amazon Rs.$price');
    return price;
  }

  // Future<String> getDataFlipkart(String query) async {
  //   var url = 'https://www.flipkart.com/search?q=';
  //   url = url + query;
  //   var response = await http.get(Uri.parse(url));
  //   dom.Document html = dom.Document.html(response.body);
  //   final priceList = html
  //       .querySelectorAll('div.KzDlHZ')
  //       .map((element) => element.text)
  //       .toList();
  //   List<String> three = [
  //     priceList.elementAt(0),
  //     priceList.elementAt(1),
  //     priceList.elementAt(2)
  //   ];

  //   // print('flipakrt $price');s
  //   return three[0];
  // }
  Future<String> getDataFlipkart(String query) async {
    String url = 'https://www.flipkart.com/search?q=';
    url = url + query;
    var response = await http
        .get(Uri.parse(url), headers: {"Allow-Control-Allow-Origin": "*"});
    if (response.statusCode == 200) {
      var document = html.parse(
        response.body,
      );
      final element = document.querySelector('div.Nx9bqj');
      if (element != null) {
        return (element.text);
      } else {
        return ("Element not found");
      }
    } else {
      return "Something went wrong: ${response.statusCode}";
    }

    // print('flipakrt $price');s
  }

  // Future<String> getTry(String query) async {
  //   var url = 'https://www.amazon.in/s?k=';
  //   url = url + query;
  //   var response = await http.get(Uri.parse(url));
  //   while (response.statusCode != 200) {
  //     response = await http.get(Uri.parse(url));
  //     print('retrying... ${response.statusCode}');
  //   }
  //   // print(response.statusCode);
  //   dom.Document html = dom.Document.html(response.body);
  //   final List<String> priceList = html
  //       .querySelectorAll('span.a-price-whole')
  //       .map((element) => element.text)
  //       .toList();
  //   String price = priceList.elementAt(0);
  //   // print('amazon Rs.$price');
  //   return price;
  // }

  // void getPage() async {
  //   String url = 'https://www.google.com';
  //   var response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   } else {
  //     print("An Error Occured!!!!");
  //   }
  // }
}

void main() async {
  Web_scraper obj = Web_scraper();
  // print(await obj.getTry('ch520'));
  // obj.getPage();
  String extract = await obj.getDataAmazon('iphone 12');
  print(extract);
  String extract2 = await obj.getDataFlipkart('ch520');
  print(extract2);
}
