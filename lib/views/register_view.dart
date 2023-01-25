import 'package:flutter/material.dart';
import 'package:mytestapp/constants/routes.dart';
import 'package:mytestapp/dialog/show_error_dialog.dart';
import 'package:mytestapp/services/auth/auth_exceptions.dart';
import 'package:mytestapp/services/auth/auth_servise.dart';

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
                    await AuthService.firebase().createUser(email: email, password: pwd) ; 
                    AuthService.firebase().sendEmailVerification();
                    Navigator.of(context).pushNamed(verifyEmailRoute);
                  }
                  on WeakPasswordAuthException{
                    TextToast.show('Password not strong enough!');
                  }
                  on EmailAlreadyInUseAuthException{
                    TextToast.show('Email already in use!');
                  }
                  on InvalidEmailAuthException{
                    TextToast.show('Invalid Email!');
                  }
                  on GenericAuthException{
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
