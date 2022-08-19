import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UnstitchedPrints extends StatefulWidget {
  const UnstitchedPrints({Key? key}) : super(key: key);

  @override
  State<UnstitchedPrints> createState() => _UnstitchedPrintsState();
}

class _UnstitchedPrintsState extends State<UnstitchedPrints> {
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
          "Unstitched Prints",
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

