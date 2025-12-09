import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/auth_services.dart';
import '../components/common_button.dart';
import '../components/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  void login(BuildContext context) async {
    final authService = AuthServices();
    try {
      await authService.signInWithEmailPassword(emailController.text, passwordController.text);
    } catch(e) {
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text("Error"),
        content: Text(e.toString()),
      ));
    }
  }

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
          CommonButton(text: 'L O G I N', onTap: ()=>login(context)),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a buddy? ",
                style: TextStyle(color: Theme
                    .of(context)
                    .colorScheme
                    .primary),
              ),
              InkWell(
                onTap: onTap,
                child: Text(
                  "Join Now",
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
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
