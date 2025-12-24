import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFields extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final FocusNode? focusNode;


  const CustomTextFields({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller, this.suffixIcon, this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        focusNode: focusNode,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
