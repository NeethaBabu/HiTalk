import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/common_button.dart';
import '../components/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("H E Y  B U D D Y...."),
          SizedBox(height: 30),
          CustomTextFields(
            hintText: 'Email',
            obscureText: false,
            controller: emailController,
          ),
          SizedBox(height: 10),
          CustomTextFields(
            hintText: 'Password',
            obscureText: true,
            controller: passwordController,
          ),
          SizedBox(height: 35),
          CommonButton(text: 'L O G I N', onTap: () {}),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a buddy? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              InkWell(
                onTap: onTap,
                child: Text(
                  "Join Now",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
