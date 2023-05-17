

import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';

class SearchCustom extends SearchDelegate {
  List<dynamic> products;
  SearchCustom(this.products);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(
            Icons.clear,
            color: kColor,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(fontSize: 50, color: Colors.blue),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> productSearch = products.where((history) {
      final result = products.toString().toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        final shistory = productSearch[index];
        return ListTile(
          title: Text(shistory),
          onTap: () {
            query = shistory;
            showResults(context);
          },
        );
      },
      itemCount: productSearch.length,
    );
  }
}
