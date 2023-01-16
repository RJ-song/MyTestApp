import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mytestapp/views/login_view.dart';
import 'package:mytestapp/views/register_view.dart';
import 'firebase_options.dart';

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
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/' : (context) => const RegisterView(),
      },
    ),
    );
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

 @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
          builder:(context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.done:
              // final user =FirebaseAuth.instance.currentUser;
              // if(user?.emailVerified??false){
              //    return const Text('done');
              // }
              // else{
              //   return const VerifyEmailView();
              // }
              return const LoginView(); 
          default:
          return const Text('Loading...');
            }
          },
        );
  }
}







