import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mytestapp/views/login_view.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blueGrey,
      ),
      home: const LoginView(),
    ),
    );
}


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
      appBar: AppBar(
        title: const Text('Register'), 
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
                 final userCredential = 
                 await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email, 
                  password: pwd
                  );
                  print(userCredential);
                }
                on FirebaseAuthException catch(e){
                  switch(e.code){
                    case 'weak-password' :
                    print('Password not strong enough!');
                    break;
                    case 'email-already-in-use':
                    print('Email already in use!');
                    break;
                    case 'invalid-email':
                    print('Invalid Email!');
                    break;
                    default :
                    break;
                  }
                }
              }, child: const Text('Register')),
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






