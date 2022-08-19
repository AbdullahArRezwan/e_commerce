import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HalfSleeveTShirt extends StatefulWidget {
  const HalfSleeveTShirt({Key? key}) : super(key: key);

  @override
  State<HalfSleeveTShirt> createState() => _HalfSleeveTShirtState();
}

class _HalfSleeveTShirtState extends State<HalfSleeveTShirt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        iconTheme: IconThemeData(
          color: Colors.lightBlue,
        ),
        title: Text(
          "Short Sleeve T-Shirt",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 34.sp,
            fontWeight: FontWeight.w900,
            color: Colors.lightBlue,
          ),
        ),
      ),
      body: SingleChildScrollView(),
    );
  }
}

