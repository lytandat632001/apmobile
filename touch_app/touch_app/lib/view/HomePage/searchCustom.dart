import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/details.dart/details.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<dynamic> products;

  CustomSearchDelegate(this.products);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products
        .where((product) =>
            product['title'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];

        return ListTile(
          leading: Image.asset(
            product['image'],
            width: 50,
            height: 50,
          ),
          title: Text(product['title']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details(data: product),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products
        .where((product) =>
            product['title'].toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        String formattedPrice =
            product['price'].split('.')[0]; // Lấy phần nguyên
        // Thêm dấu chấm ngăn cách hàng nghìn
        final pattern = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
        formattedPrice = formattedPrice.replaceAllMapped(
            pattern, (match) => '${match.group(1)}.');

        String formattedPriceBase =
            product['priceBase'].split('.')[0]; // Lấy phần nguyên
        // Thêm dấu chấm ngăn cách hàng nghìn
        final patternBase = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
        formattedPriceBase = formattedPriceBase.replaceAllMapped(
            patternBase, (match) => '${match.group(1)}.');

        return ListTile(
          leading: Image.asset(
            product['image'],
            width: 50,
            height: 50,
          ),
          title: Text(product['title']),
          subtitle: Text('₫${formattedPriceBase}'),
          // Add other information about the product
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details(data: product),
              ),
            );
          },
        );
      },
    );
  }
}
