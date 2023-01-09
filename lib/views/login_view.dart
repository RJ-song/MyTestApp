import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytestapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
      appBar: AppBar(
        title: const Text('Login'), 
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
          builder:(context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.done:
                return Column(
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
                    final userCredential = await FirebaseAuth.instance.
                 signInWithEmailAndPassword(
                  email: email, 
                  password: pwd
                  );
                  print(userCredential);
                }
                on FirebaseAuthException catch(e){
                  if(e.code == 'user-not-found'){
                    TextToast.show('User not found!');
                  }
                  else if(e.code == 'wrong-password'){
                    print('Wrong password!');
                    TextToast.show('Password incorrect');
                  }
                }
                catch (e){
                  TextToast.show('Something went wrong! try again later!');
                  print('Something went wrong!');
                  print(e.runtimeType);
                  print(e);
                }
              }, child: const Text('Login')),
            ],
          );
          default:
          return const Text('Loading...');
            }
          },
        ),
    );
  }
}


class TextToast{
  static show(String content, {int duration = 3} ) {
    Fluttertoast.showToast(
      msg: content,
      timeInSecForIosWeb: duration,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

}