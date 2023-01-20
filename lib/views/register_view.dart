import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytestapp/constants/routes.dart';
import 'package:mytestapp/dialog/show_error_dialog.dart';
import 'package:mytestapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;

import '../Toast/toast.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _pwd;

  @override
  void initState() {
    _email=TextEditingController();
    _pwd=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: const Text('Registration'),),
       body: Column(
              children: [
                TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Email'
                  ),
                ),
                TextField(
                  controller: _pwd,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password'
                  ),
                ),
                TextButton(onPressed:() async{
                
                  final email = _email.text;
                  final pwd = _pwd.text;
                  try{                   
                   await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email, 
                    password: pwd
                    );    
                    final user = FirebaseAuth.instance.currentUser;
                    await user?.sendEmailVerification();
                    Navigator.of(context).pushNamed(verifyEmailRoute);
                  }
                  on FirebaseAuthException catch(e){
                    switch(e.code){
                      case 'weak-password' :
                      TextToast.show('Password not strong enough!');
                      break;
                      case 'email-already-in-use':
                      TextToast.show('Email already in use!');
                      break;
                      case 'invalid-email':
                      TextToast.show('Invalid Email!');
                      break;
                      default :
                      break;
                    }
                  }
                  catch(e){           
                    await showErrorDialog(context, 'Something went wrong! please try again later.');
                  }
                }, child: const Text('Register')),
                TextButton(onPressed: () {
                   Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, 
                (route) => false);
                }, child: const Text('already registered? click here to login'))
              ],
            ),
     );
  }
}
