import 'package:e_commerce/Authentication/Sign_in.dart';
import 'package:e_commerce/Top-Screens/Screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DecisionPage extends StatelessWidget {
  DecisionPage({Key? key}) : super(key: key);

  final storage = new FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if(value == null){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLoginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if(snapshot.data == false){
          return Sign_in();
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Screens();
      },
    );;
  }
}
