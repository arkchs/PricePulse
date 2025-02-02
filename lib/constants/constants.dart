import 'package:flutter/material.dart';

//List of the E-commerce websites that list the searched product
List<String> companyList = [
  'Amazon',
  'Flipkart',
  'E-Bay',
  'Amazon',
  'Flipkart',
  'E-Bay',
  'Amazon',
  'Flipkart',
  'E-Bay'
];

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.white,
        child: Column(
          children: [
            Image.asset(
              'assets/product_sample.jpg',
              height: size.height * 0.5,
              fit: BoxFit.fill,
            ),
            Text(title, style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
    );
  }
}
