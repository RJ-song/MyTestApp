
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;

import 'package:mytestapp/constants/routes.dart';
import 'package:mytestapp/dialog/show_error_dialog.dart';

import '../Toast/toast.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
       appBar: AppBar(title:const Text('Login')),
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
                     await FirebaseAuth.instance.
                   signInWithEmailAndPassword(
                    email: email, 
                    password: pwd
                    );
                    Navigator.of(context).
                    pushNamedAndRemoveUntil(notesRoute, (route) => false
                    );
                  }
                  on FirebaseAuthException catch(e){
                    if(e.code == 'user-not-found'){
                      TextToast.show('User not found!');
                    }
                    else if(e.code == 'wrong-password'){
                      TextToast.show('Password incorrect');
                    }
                  }
                  catch (e){
                    await showErrorDialog(context, 'Somgthing went wrong! try again later');
                    devtools.log('Something went wrong!');
                    devtools.log(e.runtimeType.toString());
                    devtools.log(e.toString());
                  }
                }, child: const Text('Login')),
                
                TextButton(onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, 
                  (route) => false);
                },
                 child: const Text('Not registered yet? click here to register')
                 )
              ],
            ),
     );
  }
}



