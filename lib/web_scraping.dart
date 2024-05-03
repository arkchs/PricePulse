import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
class Web_scraper {
  Future<String> getDataAmazon(String query) async {
    Map<String,String> reqHeader = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Language": "en-US,en;q=0.5",
        "Accept-Encoding": "gzip, deflate, br",
        "Referer": "https://www.google.com/",
        "DNT": "1",
        "Connection": "keep-alive",
        "Upgrade-Insecure-Requests": "1"
    };
    var url = 'https://www.amazon.in/s?k=';
    url = url + query;
    var response = await http.get(Uri.parse(url), headers: reqHeader);
    while(response.statusCode!=200)
    {
      response = await http.get(Uri.parse(url), headers: reqHeader);
      print('retrying... ${response.statusCode}');
    }
    // print(response.statusCode);
    dom.Document html = dom.Document.html(response.body);
    final List<String> priceList = html
        .querySelectorAll('span.a-price-whole')
        .map((element) => element.text)
        .toList();
    String price=priceList.elementAt(0);
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