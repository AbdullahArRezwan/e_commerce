import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MensPunjabi extends StatefulWidget {
  const MensPunjabi({Key? key}) : super(key: key);

  @override
  State<MensPunjabi> createState() => _MensPunjabiState();
}

class _MensPunjabiState extends State<MensPunjabi> {
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
          "Men's Punjabi",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 34.sp,
            fontWeight: FontWeight.w900,
            color: Colors.lightBlue,
          ),
        ),
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("Mens-Punjabi").snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError)
              return Center(child: Text("Something went wrong"));
            else if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText('Loading',
                        textStyle: TextStyle(
                            fontSize: 40.sp,
                            fontFamily: "Horizon",
                            color: Colors.lightBlue)),
                  ],
                ),
              );
            else
              return Padding(
                padding: EdgeInsets.all(15.w),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot products = snapshot.data!.docs[index];
                    return ProductCard(
                      image: products["Product-Image"][0],
                      name: products["Name"],
                      price: products["Price"],
                    );
                  },
                ),
              );
          }),
    );
  }

  Widget ProductCard({image, name, price}) {
    return InkWell(
      onTap: () {},
      child: AspectRatio(
        aspectRatio: 1.2,
        child: Container(
          height: 300.h,
          width: double.infinity,
          padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.only(bottom: 20.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 10.r,
                    offset: Offset(0.w, 10.w))
              ]),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Icon(Icons.favorite_border, size: 30.w),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                right: 0,
                child: Container(
                  width: 350.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.black38,
                  ),
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    "${name}",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.zenKurenaido(
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 100.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.black38,
                  ),
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    "BDT ${price.toString()}",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.zenKurenaido(
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
