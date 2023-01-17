import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mytestapp/views/login_view.dart';
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
        '/login/': (context) => const LoginView(),
        '/register/' : (context) => const RegisterView(),
        '/notes/' :(context) => const NoteView(),
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
              final user =FirebaseAuth.instance.currentUser;
              if(user != null){
                if(user.emailVerified){
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

enum MenuAction{
  logout
}


class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        actions: [
           PopupMenuButton<MenuAction>(onSelected:(value) async{
            switch(value) {
              
              case MenuAction.logout:
                final shouldLogout = await showLogoutDialog(context);
                if(shouldLogout){
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login/', (_) => false);
                }
                
                break;
            }
          },itemBuilder: (context) {
            return const[ 
              PopupMenuItem<MenuAction>(
              value: MenuAction.logout,
              child: Text('Log out')),];
              
          })
        ],
        ),
      body: const Text('Hello'),
    );
  }
}


Future<bool> showLogoutDialog(BuildContext context){
  return showDialog<bool>(context: context, 
  builder: (context) {
    return AlertDialog(
      title: const Text('Log Out'),
      content: const Text('sure to log out?'),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop(false);
        }, child: const Text('Cancel')),
        TextButton(onPressed: () {
          Navigator.of(context).pop(true);
        }, child: const Text('Log Out')),
      ],
    );
    },
  ).then((value) => value ?? false);
}

