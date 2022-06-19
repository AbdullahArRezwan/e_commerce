import 'package:e_commerce/Constatnt/Utils.dart';
import 'package:e_commerce/Top-Screens/Profile/Edit_profile.dart';
import 'package:e_commerce/Top-Screens/Screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTP extends StatefulWidget {
  final String phone;
  final String countryCode;

  OTP({Key? key, required this.phone,  required this.countryCode}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController otpController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? verificationCode;

  @override
  void initState() {
    super.initState();
    verifyMobileNumber();
  }

  verifyMobileNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.countryCode+widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
            if(value.user != null){
              Fluttertoast.showToast(
                msg: "Account successfully created",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.lightBlue,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Screens()));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e){
          Utils.showSnackBar(e.message.toString());
        },
        codeSent: (String verificationId, int? resendToken){
          setState(() {
            verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId){
          setState(() {
            verificationCode = verificationId;
          });
        },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Container(
                        alignment: Alignment.center,
                        width: 190.w,
                        height: 190.h,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Image.asset(
                            'assets/images/mobile_animation.jpg',
                          ),
                        )
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("Verify your mobile number",
                        style: GoogleFonts.zenKurenaido(
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 38.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("${widget.phone}",
                        style: GoogleFonts.zenKurenaido(
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("please enter the 6-digit verification code that was",
                        style: GoogleFonts.zenKurenaido( //supermercadoOne
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("sent to your mobile number",
                        style: GoogleFonts.zenKurenaido( //supermercadoOne
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        children: [
                          Pinput(
                            length: 6,
                            focusNode: _pinOTPCodeFocus,
                            controller: otpController,
                            androidSmsAutofillMethod:  AndroidSmsAutofillMethod.smsRetrieverApi,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            validator: (pin) {
                              return pin == otpController.text ? 'Pin is correct' : 'Pin is incorrect';
                            },
                            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) async {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithCredential(PhoneAuthProvider
                                    .credential(verificationId: verificationCode!, smsCode: pin))
                                    .then((value){
                                  if(value.user != null){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Screens()));
                                  }
                                });
                              } catch (e) {
                                FocusScope.of(context).unfocus();
                                Utils.showSnackBar("OTP is incorrect");
                              }
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Didn't you receive any code?",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    GestureDetector(
                      onTap: verifyMobileNumber,
                      child: Text(
                        "Resend again",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                        textAlign: TextAlign.center,
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

PageRouteBuilder _buildScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Screens();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  );
}
