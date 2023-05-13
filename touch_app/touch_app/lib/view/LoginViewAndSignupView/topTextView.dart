// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TopTextView extends StatefulWidget {
  const TopTextView({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<TopTextView> createState() => _TopTextViewState();
}

class _TopTextViewState extends State<TopTextView> {


  @override
  Widget build(BuildContext context) {
    return Text(
      // widget.state == true ? 'Create\nAccount' : 'Welcome\nBack',
      widget.title,
      // ignore: prefer_const_constructors
      style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.transparent),
    );
  }
}
