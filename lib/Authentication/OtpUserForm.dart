import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Constatnt/Utils.dart';
import 'package:e_commerce/Top-Screens/Screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpUserForm extends StatefulWidget {
  final String phone;
  const OtpUserForm({Key? key, required this.phone}) : super(key: key);

  @override
  State<OtpUserForm> createState() => _OtpUserFormState();
}

class _OtpUserFormState extends State<OtpUserForm> {

  final formKey = GlobalKey<FormState>();
  String fullName = '';
  String phone = '';
  String email = '';
  String address = '';
  String newPassword = '';
  bool _obscurePass = true;
  bool _obscureConfirmPass = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  registration() async {
    try {
      CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection("UserData");
      return _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).set({
        "FullName": nameController.text.trim(),
        "Email": emailController.text.trim(),
        "PhoneNumber": widget.phone,
        "Password": passwordController.text.trim(),
        "Address": addressController.text.trim(),
        "ImageUrl": "https://firebasestorage.googleapis.com/v0/b/e-shop-273fa.appspot.com/o/UserProfile%2Ficon.jpg?alt=media&token=94932f6e-c31b-465f-b4d2-0e5c8715be3f",
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.w, bottom: 20.w),
          child:  Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                    "User Information",
                  style: GoogleFonts.zenKurenaido(
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
                SizedBox(height: 40.h),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Enter at least 6 characters';
                    } else if (value.isEmpty) {
                      return "Enter your name";
                    } else {
                      return null;
                    }
                  },
                  maxLength: 50,
                  onSaved: (value) => setState(() => fullName = value!),
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: phoneController = TextEditingController(text: widget.phone),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: "Your Phone Number",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    prefixIcon: Icon(Icons.call),
                  ),
                  validator: (value) {
                    final pattern = r'(^[0-9]{11}$)';
                    final regExp = RegExp(pattern);
                    if (value!.isEmpty) {
                      return 'Enter your phone number';
                    } else if (!regExp.hasMatch(value)) {
                      return 'Enter a valid phone number';
                    } else {
                      return null;
                    }
                  },
                  maxLength: 11,
                  onSaved: (value) => setState(() => phone = value!),
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: "Your Email",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    prefixIcon: Icon(Icons.mail),
                  ),
                  validator: (value) {
                    final pattern =
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                    final regExp = RegExp(pattern);

                    if (!regExp.hasMatch(value!)) {
                      return 'Enter a valid email';
                    } else {
                      return null;
                    }
                  },
                  maxLength: 50,
                  onSaved: (value) => setState(() => email = value!),
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: "Your Address",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    prefixIcon: Icon(Icons.house),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your address';
                    } else {
                      return null;
                    }
                  },
                  maxLength: 200,
                  onSaved: (value) => setState(() => address = value!),
                ),
                SizedBox(height: 16.h),
                Text(
                    "Create own password",
                  style: GoogleFonts.zenKurenaido(
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.lightBlue,
                  ),
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (pass) {
                    if(RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(pass!)){
                      return null;
                    }
                    else if(pass.isEmpty)
                    {
                      return "Please enter password";
                    }
                    else{
                      return "Minimum 8 character long with special character, uppercase & lowercase\n"
                          "letter with number";
                    }
                  },
                  obscureText: _obscurePass,
                  decoration: InputDecoration(
                    hintText: "Password",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                      prefixIcon: Icon(CupertinoIcons.lock,
                        color: Colors.lightBlue,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePass = !_obscurePass;
                          });
                        },
                        icon: _obscurePass?Icon(Icons.visibility_off, color: Colors.lightBlue):Icon(Icons.visibility, color: Colors.lightBlue),
                      ),
                  ),
                ),
                SizedBox(height: 16.w),
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: confirmPasswordController,
                  obscureText: _obscureConfirmPass,
                  validator: (value) {
                    if(passwordController.text != confirmPasswordController.text){
                      return "Password does not match";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.r)),
                    prefixIcon: Icon(CupertinoIcons.lock,
                      color: Colors.lightBlue,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPass =! _obscureConfirmPass;
                        });
                      },
                      icon: _obscurePass?Icon(Icons.visibility_off, color: Colors.lightBlue):Icon(Icons.visibility, color: Colors.lightBlue),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 57.h,
                    child: ElevatedButton(
                      onPressed: () {
                        final isValid = formKey.currentState!.validate();

                        if (isValid) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Screens()));
                          registration();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Account successfully created")));
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightBlue),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
      ),
    );
  }
}
