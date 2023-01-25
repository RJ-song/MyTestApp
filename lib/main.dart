import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mytestapp/constants/routes.dart';
import 'package:mytestapp/services/auth/auth_servise.dart';
import 'package:mytestapp/views/login_view.dart';
import 'package:mytestapp/views/note_view.dart';
import 'package:mytestapp/views/register_view.dart';
import 'package:mytestapp/views/verify_emil_view.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

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
        loginRoute: (context) => const LoginView(),
        registerRoute : (context) => const RegisterView(),
        notesRoute :(context) => const NoteView(),
        verifyEmailRoute:(context) => const VerifyEmailView(),
      },
    ),
    );
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

 @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: AuthService.firebase().initialize(),
          builder:(context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if(user != null){
                if(user.isEmailVerified){
                  devtools.log('Email is verified');
                }
                else{
                  return const VerifyEmailView();
                }
              }
              else{
                return const LoginView();
              }
              
              return const NoteView(); 
          default:
          return const Text('Loading...');
            }
          },
        );
  }
}


