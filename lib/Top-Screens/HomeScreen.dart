import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Center(
          child: Text("Home Screen",
          style: TextStyle(
            color: Colors.lightBlue,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
      ),
    );
  }
}

