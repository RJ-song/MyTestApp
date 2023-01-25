import 'package:mytestapp/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:mytestapp/services/auth/auth_servise.dart';

import '../enums/menu_action.dart';

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
                  await AuthService.firebase().logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute, (_) => false);
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