import 'package:e_commerce/Authentication/Sign_in.dart';
import 'package:e_commerce/Authentication/Sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    if(!isLogin){
      return Sign_up();
    } else {
      return Sign_in();
    }
  }
}
