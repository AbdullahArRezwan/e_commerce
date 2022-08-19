import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Authentication/Sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String newPassword = '';
  bool _obscurePass = true;
  bool _obscureConfirmPass = true;

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose(){
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  updateData() {
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("UserData");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "Password": _passwordController.text.trim(),
    });
  }


  Future changePassword() async {
    try{
      await currentUser!.updatePassword(newPassword);
      updateData();
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Sign_in()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your password has been changed. Login again")));
    } catch (e){
      print(e);
    }
  }

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
        title: Text("Change Password",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please enter your new password",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30.h),
              TextFormField(
                controller: _passwordController,
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
                  hintText: "New Password",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
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
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlue,
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.w),
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPass,
                validator: (value) {
                  if(_passwordController.text!=_confirmPasswordController.text){
                    return "Password does not match";
                  }
                },
                decoration: InputDecoration(
                  hintText: "Confirm new Password",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  prefixIcon: Icon(CupertinoIcons.lock,
                    color: Colors.lightBlue,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPass = !_obscureConfirmPass;
                      });
                    },
                    icon: _obscureConfirmPass?Icon(Icons.visibility_off, color: Colors.lightBlue):Icon(Icons.visibility, color: Colors.lightBlue),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 57.h,
                  child: ElevatedButton(
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();
                      if (isValid) {
                        setState((){
                          newPassword = _passwordController.text.trim();
                        });
                        changePassword();
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
