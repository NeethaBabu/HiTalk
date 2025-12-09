import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msg_app/auth/auth_services.dart';

import '../components/common_button.dart';
import '../components/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPswController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  void register(BuildContext context) async {
    final _auth =AuthServices();
    //password match
    if(passwordController.text==confirmPswController.text) {
      try {
        await _auth.signUpWithEmailPassword(
            emailController.text, passwordController.text);
      }
      catch(e) {
        showDialog(context: context, builder: (context)=> AlertDialog(
          title: Text("Error"),
          content: Text(e.toString()),
        ));
      }
    }
    else {
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text("Ooh its not matching"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("J O I N   W I T H  A S...."),
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
          SizedBox(height: 10),
          CustomTextFields(
            hintText: 'Confirm Password',
            obscureText: true,
            controller: confirmPswController,
          ),
          SizedBox(height: 35),
          CommonButton(text: 'J O I N', onTap: ()=>register(context)),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already joined our team? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              InkWell(
                onTap: onTap,
                child: Text(
                  "Login Now",
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
