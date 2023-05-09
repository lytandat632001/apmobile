// ignore_for_file: file_names

import 'package:flutter/material.dart';

class IconCheck extends StatefulWidget {
  const IconCheck({
    Key? key,
    required this.titleBottomSheet,
    required this.isSelected,
  }) : super(key: key);
  final String titleBottomSheet;
  final bool isSelected;

  @override
  State<IconCheck> createState() => _IconCheckState();
}

class _IconCheckState extends State<IconCheck> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.titleBottomSheet),
        Icon(
          Icons.check,
          color: widget.isSelected == true ? Colors.black : Colors.transparent,
        ),
      ],
    );
  }
}
