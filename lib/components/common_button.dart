import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CommonButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}
