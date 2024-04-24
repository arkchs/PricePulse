import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class Web_scraper {
  Web_scraper(String query) {
    getFlipkart(query);
    getAmazon(query);
  }
  List<String> getAmazon(String query) {
    var url = 'https://www.amazon.in/s?k=';
    url = url + query;
    http.Client().get(Uri.parse(url)).then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        var document = parser.parse(response.body);
        try {
          var response= (document.getElementsByClassName('a-price-whole')); 
          return response;
        } catch (e) {
          print(e);
          return ['', '', 'Error!'];
        }
      } else { 
      return ['', '', 'ERROR: ${response.statusCode}.']; 
      }
    });
    return ['Error!'];
  }
  List<String> getFlipkartImage(String query) {
    var url = 'https://www.flipkart.com/search?q=';
    url = url + query;
    http.Client().get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        var document = parser.parse(response.body);
        try {
          var response=(document.getElementsByClassName('_4WELSP')[0]);
          return response;
        } catch (e) {
          print(e);
          return ['', '', 'Error!'];
          
        }
      } else { 
      return ['', '', 'ERROR: ${response.statusCode}.']; 
      }
    });
    return ['Error!'];
  }
  List<String> getFlipkart(String query) {
    var url = 'https://www.flipkart.com/search?q=';
    url = url + query;
    http.Client().get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        var document = parser.parse(response.body);
        try {
          var response=(document.getElementsByClassName('wjcEIp'));
          return response;
        } catch (e) {
          print(e);
          return ['', '', 'Error!'];
        }
      } else { 
      return ['', '', 'ERROR: ${response.statusCode}.']; 
      }
    });
    return ['Error!'];
  }
}
