import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends StatelessWidget {
  final String userId;
  final List<String> userFavoritesList;
  const FavoritesPage(
      {super.key, required this.userId, required this.userFavoritesList});
  void redirectToProductPage(String productName, context) {
    productName.isNotEmpty
        ? GoRouter.of(context).go(Uri(
            path: '/product/$productName',
            queryParameters: {'query': productName}).toString())
        : ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The query cannot be empty!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue,
              )),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Favorites for $userId',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                Expanded(
                  child: ListView.builder(
                    itemCount: userFavoritesList.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () => redirectToProductPage(
                          userFavoritesList[index], context),
                      minVerticalPadding: 30.0,
                      title: Text(
                        userFavoritesList[index],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue,
              )),
        ],
      ),
    );
  }
}
