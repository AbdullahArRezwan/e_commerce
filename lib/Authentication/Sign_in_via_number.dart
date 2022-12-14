import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Authentication/OTP_Screen.dart';
import 'package:e_commerce/Constatnt/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Signin_via_number extends StatefulWidget {
  const Signin_via_number({Key? key}) : super(key: key);

  @override
  State<Signin_via_number> createState() => _Signin_via_numberState();
}

class _Signin_via_numberState extends State<Signin_via_number> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController numberController = TextEditingController();
  late String verificationId;

  sendUserDataToDB()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("UserData");
    return _collectionRef.doc(currentUser!.uid).set({
      "FullName": "Enter your name",
      "Email": "Enter your email",
      "PhoneNumber": numberController.text.trim(),
      "Password": "Enter your password",
      "Address": "Enter your address",
      "ImageUrl": "https://firebasestorage.googleapis.com/v0/b/e-shop-273fa.appspot.com/o/UserProfile%2Ficon.jpg?alt=media&token=94932f6e-c31b-465f-b4d2-0e5c8715be3f",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Padding(padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          size: 32,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: 190.w,
                      height: 190.h,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.asset(
                          'assets/images/OTP 2.jpg',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      'Sign-up via Mobile Number',
                      style: GoogleFonts.zenKurenaido(
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: 37.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.lightBlue,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Please enter your phone number. we'll send you a verification code to verify your account",
                      style: GoogleFonts.zenKurenaido( //supermercadoOne
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            controller: numberController,
                            maxLength: 11,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10.r)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10.r)),
                              prefix: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '(+880)',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.check_circle,
                                color: Colors.lightBlue,
                                size: 22,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OTP(
                                  phone: numberController.text,
                                  countryCode: "+88",
                                )));
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.lightBlue),
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.r),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  'Send',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
