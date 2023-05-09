// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';

class TopContainer extends StatelessWidget {
  const TopContainer(
      {super.key, required this.title, required this.searchBartitile});
  final String title;
  final String searchBartitile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: theme.displayLarge?.copyWith(
                color: kColor,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ],
        )
      ],
    );
  }
}
