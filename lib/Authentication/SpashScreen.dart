import 'dart:async';
import 'package:e_commerce/Authentication/DecisionPage.dart';
import 'package:e_commerce/Authentication/Sign_in.dart';
import 'package:e_commerce/Top-Screens/Screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static String routeName = "/splash";

  @override
  void initState() {
    Timer(Duration(seconds: 3),()=>Navigator.push(context, CupertinoPageRoute(builder: (_) => DecisionPage())));
    // Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.push(context, CupertinoPageRoute(builder: (_) => Sign_in())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "E-Shop",
                style: GoogleFonts.zenKurenaido(
                  //supermercadoOne
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  fontSize: 70.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.lightBlue,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CircularProgressIndicator(
                color: Colors.lightBlue,
              ),
            ],
          ),
        ),
      ),

      // body: FutureBuilder(
      //   future: checkLoginStatus(),
      //     builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
      //       if(snapshot.data == false){
      //         return Sign_in();
      //       }
      //       if(snapshot.connectionState == ConnectionState.waiting){
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       return Screens();
      //     },
      // ),

      // StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot){
      //     if(snapshot.connectionState == ConnectionState.waiting){
      //       return Center(child: CircularProgressIndicator());
      //     } else if(snapshot.hasError){
      //       return Center(child: Text("Something went wrong!"));
      //     } else if(snapshot.hasData){
      //       return Screens();
      //     } else {
      //       return AuthPage();
      //     }
      //   },
      // ),
    );
  }
}
