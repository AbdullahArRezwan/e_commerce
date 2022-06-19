import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Authentication/EmailVerification.dart';
import 'package:e_commerce/Authentication/Sign_in_via_number.dart';
import 'package:e_commerce/Firebase-Logic/GoogleSignInProvider.dart';
import 'package:e_commerce/Authentication/OTP_Screen.dart';
import 'package:e_commerce/Authentication/Sign_in.dart';
import 'package:e_commerce/Constatnt/Utils.dart';
import 'package:e_commerce/Constatnt/Social_Buttons.dart';
import 'package:e_commerce/Firebase-Logic/PictureLogic.dart';
import 'package:e_commerce/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var name = "";
  var email = "";
  var password = "";
  var confirmPassword = "";
  bool _obscurePass = true;
  bool _obscureConfirmPass = true;

  void clearText() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  registration() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
        );
        var authCredential = userCredential.user;
        if(authCredential!.uid.isNotEmpty){
          Navigator.push(context, CupertinoPageRoute(builder: (_) => EmailVerification(email: email)));
        } else {
          Fluttertoast.showToast(msg: "Something went wrong");
        }
        // final FirebaseAuth _auth = FirebaseAuth.instance;
        // FirebaseFirestore.instance.collection('UserInfo').doc(currentUser!.email).set({
        //   //'uid': user?.uid,
        //   'Name': name,
        //   'Email': email,
        //   'Password': password,
        //   'Phone': '',
        //   'Address': '',
        // }).then((value) => Navigator.pushReplacement(context,
        //   MaterialPageRoute(builder: (context) => EmailVerification(email: email),
        //   ))).catchError((error) => print('Failed to Add User: $error'));
        await FirebaseFirestore.instance
            .collection('UserData')
            .doc(userCredential.user!.uid)
            .set({
          "FullName": _nameController.text.trim(),
          "Email": _emailController.text.trim(),
          "Userid": userCredential.user!.uid,
          "Password": _passwordController.text.trim(),
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(msg: "The account already exists for that email.");
        }
        Utils.showSnackBar(e.message);
      }
  }

  @override
  Widget build(BuildContext context) {
    // final SignUpStyle = Provider.of<PictureAdd>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(40.w),
            child: Column(
              children: [
                SizedBox(height: 80.h),
                Hero(
                  tag: 'text',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'Welcome to our Community!',
                      style: GoogleFonts.zenKurenaido(
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: _nameController,
                  onChanged: (value) {
                    name = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.person,
                      color: Colors.lightBlue,
                    ),
                    suffixIcon: IconButton(onPressed: null,
                      icon: Icon(Icons.check_circle,
                        color: Colors.lightBlue,
                      ),
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
                SizedBox(height: 10.h),
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: _emailController,
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (email) {
                    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email!)){
                      return null;
                    }
                    else{
                      return "Enter a valid email";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.mail_outline,
                      color: Colors.lightBlue,
                    ),
                    suffixIcon: IconButton(onPressed: null,
                      icon: Icon(Icons.check_circle,
                        color: Colors.lightBlue,
                      ),
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
                SizedBox(height: 10.h),
                TextFormField(
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (pass) {
                    if(RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(pass!)){
                      return null;
                    }
                    else{
                      return "Minimum 8 character long with special character, uppercase & lowercase\n"
                          "letter with number";
                    }
                  },
                  obscureText: _obscurePass,
                  decoration: InputDecoration(
                    hintText: "Password",
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
                SizedBox(height: 10.h),
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
                    hintText: "Confirm Password",
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
                SizedBox(height:30.h),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'signup_button',
                        child: TextButton(
                          onPressed: () {
                            // final snackBar = SnackBar(
                            //   content: const Text('Yay! A SnackBar!'),
                            //   // action: SnackBarAction(
                            //   //   label: 'Undo',
                            //   //   onPressed: () {
                            //   //     // Some code to undo the change.
                            //   //   },
                            //   // ),
                            // );
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            // Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => EmailVerification(email: email,),
                            //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            //     return SlideTransition(
                            //       position: Tween<Offset>(
                            //         begin: const Offset(1.0, 0.0),
                            //         end: const Offset(0.0, 0.0),
                            //       ).animate(animation),
                            //       child: child,
                            //     );
                            //   },
                            //   transitionDuration: const Duration(seconds: 1),
                            //   reverseTransitionDuration: const Duration(seconds: 1),
                            // ),
                            // );
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                name = _nameController.text;
                                email = _emailController.text;
                                password = _passwordController.text;
                                confirmPassword = _confirmPasswordController.text;
                              });
                              registration();
                            }
                          },
                          child: Text('Sign up'),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            primary: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 18.0,
                            ),
                            shape: StadiumBorder(),
                          ),
                        ),
                      ),
                    ]
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    _viaMobileNumber(),
                  ),
                  child: Text('Sign-up Via Number',
                      style: TextStyle(
                        color: Colors.lightBlue,
                      )),
                ),
                Hero(
                  tag: 'social_buttons',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SocialButton(
                        backgroundColor: Colors.lightBlue,
                        icon: FontAwesomeIcons.facebookF,
                        onPressed: () {
                          _launchInBrowser('https://www.facebook.com');
                        },
                      ),
                      SocialButton(
                        backgroundColor: Colors.red,
                        icon: FontAwesomeIcons.google,
                        onPressed: () {
                          final gProvider = Provider.of<GoogleSignInProvider>(context, listen: false);
                          gProvider.googleLogIn();
                          // SignUpStyle.gSignUp();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text("Already have an account?"),
                SizedBox(height: 16.h),
                Hero(
                  tag: 'signin_button',
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(_backSignIn());
                      clearText();
                    },
                    child: Text('Sign in'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 18.0,
                      ),
                      shape: StadiumBorder(),
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
Future<void> _launchInBrowser(String url) async {
  if (!await launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    throw 'Could not launch $url';
  }
}

PageRouteBuilder _viaMobileNumber() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Signin_via_number();
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
PageRouteBuilder _backSignIn() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Sign_in();
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