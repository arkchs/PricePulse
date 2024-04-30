import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
class Web_scraper {
  Future<String> getDataAmazon(String query) async {
    var url = 'https://www.amazon.in/s?k=';
    url = url + query;
    var response = await http.get(Uri.parse(url));
    // print(response.statusCode);
    dom.Document html = dom.Document.html(response.body);
    final priceList = html
        .querySelectorAll('span.a-price-whole')
        .map((element) => element.text)
        .toList();
    String price=priceList.elementAt(3);
    // print('amazon Rs.$price');
    return price;
  }

  Future<String> getDataFlipkart(String query) async {
    var url = 'https://www.flipkart.com/search?q=';
    url = url + query;
    var response = await http.get(Uri.parse(url));
    dom.Document html = dom.Document.html(response.body);
    final priceList = html
        .querySelectorAll('div.Nx9bqj')
        .map((element) => element.text)
        .toList();
    var price = priceList.elementAt(2);
    // print('flipakrt $price');
    return price;
  }
}
void main() async
{
  Web_scraper obj = new Web_scraper();
  String extract=await obj.getDataAmazon('iphone 12');
  print(extract);
  // obj.getDataFlipkart('iphone 12');
}