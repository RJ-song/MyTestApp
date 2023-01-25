
import 'package:flutter/material.dart';
import 'package:mytestapp/constants/routes.dart';
import 'package:mytestapp/dialog/show_error_dialog.dart';
import 'package:mytestapp/services/auth/auth_exceptions.dart';
import 'package:mytestapp/services/auth/auth_servise.dart';
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
                    AuthService.firebase().logIn(
                      email: email, 
                      password: pwd,
                      );
                    final user = AuthService.firebase().currentUser;
                    if(user?.isEmailVerified??false){
                      Navigator.of(context).
                      pushNamedAndRemoveUntil(notesRoute, (route) => false
                    );
                    }
                    else{
                      Navigator.of(context).
                    pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false
                    );
                    }
                    
                  }
                  on UserNotFoundAuthException{
                      TextToast.show('User not found!');
                  }
                  on WrongPasswordAuthException{
                      TextToast.show('Password incorrect');
                  }
                  on GenericAuthException{
                    await showErrorDialog(context, 'something went wrong');
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



