import 'dart:async';
import 'package:e_commerce/Authentication/Sign_in.dart';
import 'package:e_commerce/Constatnt/Utils.dart';
import 'package:e_commerce/Top-Screens/Screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerification extends StatefulWidget {
  String email;
  EmailVerification({Key? key, required this.email}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState(email);
}

class _EmailVerificationState extends State<EmailVerification> {
  late String email;
  _EmailVerificationState(this.email);
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3), (_) => checkEmailVerified(),
      );
    }
  }

  void dispose(){
   timer?.cancel();
   super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e){
      Utils.showSnackBar(e.toString());
    }
  }

  Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if(isEmailVerified)
      return Screens();
    else
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(padding: EdgeInsets.symmetric(
            vertical: 10.w,
            horizontal: 12.w,
          ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
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
                      SizedBox(height: 20.h),
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Image.asset(
                              'assets/images/OTP 1.jpg',
                            ),
                          )
                      ),
                      SizedBox(height: 50.h),
                      Text("Verify your email address",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.zenKurenaido( //supermercadoOne
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 38.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.lightBlue,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("A verification link has been sent to",
                        style: GoogleFonts.zenKurenaido( //supermercadoOne
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(email,
                        style: GoogleFonts.zenKurenaido( //supermercadoOne
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                        child: SizedBox(
                          width: double.infinity,
                          height: 57.h,
                          child: ElevatedButton(
                            onPressed: !canResendEmail ? sendVerificationEmail : null,
                            style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.lightBlue),
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: Colors.white,
                                      size: 24.w,
                                    ),
                                    SizedBox(width: 15.w),
                                    Text(
                                      'Resent Email',
                                      style: TextStyle(fontSize: 22.sp),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(30)),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut().then((value)=>Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Sign_in())));
                          },
                          child: Text("Cancel",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.lightBlue,
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  // showCustomToast(){
  //   Widget toast = Container(
  //     padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(25.0),
  //       color: Colors.greenAccent,
  //     ),
  //     child: Text("This is a Custom Toast"),
  //   );
  //
  //   show_toast.showToast(
  //     child: toast,
  //     toastDuration: Duration(seconds: 3),
  //   );
  // }

  Widget _textFieldOTP({required bool first, last}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: AspectRatio(
        aspectRatio: 0.55,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.w, color: Colors.black12),
                borderRadius: BorderRadius.circular(12.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.w, color: Colors.lightBlue),
                borderRadius: BorderRadius.circular(12.r)),
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


