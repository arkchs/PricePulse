import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

void main() async {
  final router = Router();
  router.get('/scrape', (Request request) async {
    final String? query = request.url.queryParameters['q'];
    final String url = 'https://flipkart.com/search?q=$query';
    if (query == null) {
      return Response.badRequest(body: 'Missing "url" query parameter');
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        return Response.internalServerError(body: 'Failed to fetch webpage');
      }

      final document = html_parser.parse(response.body);

      final List<String> element = document
          .querySelectorAll('div.Nx9bqj')
          .map((element) => element.text)
          .toList();
      return Response.ok('{"data": "$element"}', headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*', // Manually add CORS headers
      });
    } catch (e) {
      return Response.internalServerError(body: 'Scraping error: $e');
    }
  });

  router.get('/scrape-amazon', (Request request) async {
    final String? query = request.url.queryParameters['q'];
    final url = 'https://amazon.in/s?k=$query';
    if (query == null) {
      return Response.badRequest(body: 'Missing "url" query parameter');
    }
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
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };

    try {
      final response = await http.get(Uri.parse(url), headers: reqHeader);
      if (response.statusCode != 200) {
        return Response.internalServerError(body: 'Failed to fetch webpage');
      }

      final document = html_parser.parse(response.body);
      final List<String> element = document
          .querySelectorAll('span.a-price-whole')
          .map((element) => element.text)
          .toList();
      final List<String> imageLink = document
          .querySelectorAll(
            'img.s-image',
          )
          .map((e) => e.attributes['src'] ?? '')
          .toList();

      return Response.ok('{"data": "$element", "imageLink":"$imageLink"}',
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
          });
    } catch (e) {
      return Response.internalServerError(body: 'Scraping error: $e');
    }
  });

  // CORS Middleware
  final handler = Pipeline()
      .addMiddleware((innerHandler) => (request) async {
            final response = await innerHandler(request);
            return response.change(headers: {
              ...response.headers,
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
              'Access-Control-Allow-Headers': 'Content-Type',
            });
          })
      .addHandler(router);

  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 5000);
  print('Server running on http://${server.address.host}:${server.port}');
}
