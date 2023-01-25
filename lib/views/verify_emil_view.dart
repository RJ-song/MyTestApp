import 'package:flutter/material.dart';
import 'package:mytestapp/constants/routes.dart';
import 'package:mytestapp/services/auth/auth_servise.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => VerifyEmailViewState();
}

class VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('verify email'),),
      body: Column(children: [
        const Text("Please open the email we sent to verify your account"),
        const Text("if you haven't receive our email, press 'Send Email verification'."),
        TextButton(onPressed: () async{
          await AuthService.firebase().sendEmailVerification();
        }, 
        child: const Text('Send Email verification'),),
        TextButton(onPressed:() async{
            await AuthService.firebase().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute,
              (route) => false,
            );
        }, child: const Text('restart'),)
      ],),
    );
  }
}