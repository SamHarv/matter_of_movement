import 'package:flutter/material.dart';

import '../constants.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.mediaWidth,
    required this.controller,
    required this.hintText,
    required this.obscure,
  }) : super(key: key);

  final double mediaWidth;
  final TextEditingController controller;
  final String hintText;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51,
      width: mediaWidth <= 750 ? mediaWidth * 0.7 : mediaWidth * 0.4,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: color),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
