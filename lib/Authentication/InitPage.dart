import 'package:e_commerce/Authentication/AuthPage.dart';
import 'package:e_commerce/Authentication/Sign_in.dart';
import 'package:e_commerce/Top-Screens/Screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        } else if(snapshot.hasError){
          return Center(child: Text("Something went wrong!"));
        } else if(snapshot.hasData){
          return Screens();
        } else {
          return Sign_in();
        }
      },
    );
  }
}
