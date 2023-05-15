// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';

class ImputWidget extends StatefulWidget {
  const ImputWidget({
    super.key,
    required this.hint,
    required this.hintIcon,
    required this.obscureText,
    this.controller,
  });
  final String hint;
  final Icon hintIcon;
  final bool obscureText;
  final controller;

  @override
  State<ImputWidget> createState() => _ImputWidgetState();
}

class _ImputWidgetState extends State<ImputWidget> {
  @override
  Widget build(BuildContext context) {
    // String hintText = widget.controller.toString();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: SizedBox(
        height: 55,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          shadowColor: Colors.black87,
          child: TextField(
            // onChanged: (value) {
            //   hintText = value;
            //   print(hintText);
            // },
            
            controller: widget.controller,
            obscureText: widget.obscureText,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(fontSize: 18),
              filled: true,
              fillColor: const Color(inputFieldColor),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              suffixIconColor: kPrimaryColor,
              suffixIcon: widget.hintIcon,
            ),
          ),
        ),
      ),
    );
  }
}
