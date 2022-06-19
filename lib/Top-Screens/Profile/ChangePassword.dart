import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();
  String new_pass = '';
  String confirm_pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        iconTheme: IconThemeData(
          color: Colors.lightBlue,
        ),
        title: Text("E-Shop",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 32.sp,
            fontWeight: FontWeight.w900,
            color: Colors.lightBlue,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30.h),
              // TextFormField(
              //   // autofocus: true,
              //   keyboardType: TextInputType.text,
              //   style: TextStyle(
              //     fontSize: 18.sp,
              //     fontWeight: FontWeight.normal,
              //   ),
              //   decoration: InputDecoration(
              //     hintText: "Your Phone Number",
              //     enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.lightBlue),
              //         borderRadius: BorderRadius.circular(10.r)),
              //     focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.lightBlue),
              //         borderRadius: BorderRadius.circular(10.r)),
              //     errorBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.lightBlue),
              //         borderRadius: BorderRadius.circular(10.r)),
              //     prefixIcon: Padding(
              //       padding: EdgeInsets.all(14.w),
              //       child: Text(
              //         "Phone",
              //         style: TextStyle(
              //           fontSize: 18.sp,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //   ),
              //   validator: (value) {
              //     final pattern = r'(^[0-9]{11}$)';
              //     final regExp = RegExp(pattern);
              //
              //     if (value!.isEmpty) {
              //       return 'Enter a phone number';
              //     } else if (!regExp.hasMatch(value)) {
              //       return 'Enter a valid phone number';
              //     } else {
              //       return null;
              //     }
              //   },
              //   maxLength: 11,
              //   onSaved: (value) => setState(() => phone = value!),
              // ),
              SizedBox(height: 16.h),
              // TextFormField(
              //   // autofocus: true,
              //   keyboardType: TextInputType.text,
              //   style: TextStyle(
              //     fontSize: 18.sp,
              //     fontWeight: FontWeight.normal,
              //   ),
              //   decoration: InputDecoration(
              //     hintText: "Your Email",
              //     enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.lightBlue),
              //         borderRadius: BorderRadius.circular(10.r)),
              //     focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.lightBlue),
              //         borderRadius: BorderRadius.circular(10.r)),
              //     errorBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.lightBlue),
              //         borderRadius: BorderRadius.circular(10.r)),
              //     prefixIcon: Padding(
              //       padding: EdgeInsets.all(14.w),
              //       child: Text(
              //         "Email",
              //         style: TextStyle(
              //           fontSize: 18.sp,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //   ),
              //   validator: (value) {
              //     final pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
              //     final regExp = RegExp(pattern);
              //
              //     if (value!.isEmpty) {
              //       return 'Enter an email';
              //     } else if (!regExp.hasMatch(value)) {
              //       return 'Enter a valid email';
              //     } else {
              //       return null;
              //     }
              //   },
              //   maxLength: 30,
              //   onSaved: (value) => setState(() => email = value!),
              // ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 57.h,
                  child: ElevatedButton(
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();
                      // FocusScope.of(context).unfocus();

                      if (isValid) {
                        formKey.currentState!.save();

                        // final message =
                        //     'Username: $username\nPassword: $password\nEmail: $email';
                        // final snackBar = SnackBar(
                        //   content: Text(
                        //     message,
                        //     style: TextStyle(fontSize: 20),
                        //   ),
                        //   backgroundColor: Colors.green,
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
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
                      child: Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
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
