import 'package:e_commerce/Firebase-Logic/GoogleSignInProvider.dart';
import 'package:e_commerce/Authentication/ResetPassword.dart';
import 'package:e_commerce/Authentication/Sign_in_via_number.dart';
import 'package:e_commerce/Authentication/Sign_up.dart';
import 'package:e_commerce/Firebase-Logic/PictureLogic.dart';
import 'package:e_commerce/Top-Screens/HomeScreen/HomeScreen.dart';
import 'package:e_commerce/Top-Screens/Screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Constatnt/Social_Buttons.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({Key? key}) : super(key: key);

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  static String routeName = "/sign_in";

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;

  var email = "";
  var password = "";
  final storage = new FlutterSecureStorage();

  userLogin() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      var authCredential = userCredential.user;
      await storage.write(key: "uid", value: userCredential.user?.uid);
      if (authCredential!.uid.isNotEmpty) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Screens()));
      } else {
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    }
  }

  signInScreen() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          children: [
            SizedBox(height: 150.h),
            Hero(
              tag: 'text',
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  'Welcome Back!',
                  style: GoogleFonts.zenKurenaido(
                    //supermercadoOne
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    fontSize: 38.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.h),
            TextFormField(
              // autovalidateMode: AutovalidateMode.always,
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Email';
                } else if (!value.contains('@')) {
                  return 'Please Enter Valid Email';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                prefixIcon: Icon(
                  Icons.mail_outline,
                  color: Colors.lightBlue,
                ),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.lightBlue,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlue,
                    )),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Password';
                }
                return null;
              },
              obscureText: _obscure,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                prefixIcon: Icon(
                  CupertinoIcons.lock,
                  color: Colors.lightBlue,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                  icon: _obscure
                      ? Icon(Icons.visibility_off, color: Colors.lightBlue)
                      : Icon(Icons.visibility, color: Colors.lightBlue),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlue,
                    )),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(children: [
              Spacer(),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  _resetPassword(),
                ),
                child: Text('Forgot Password',
                    style: TextStyle(
                      color: Colors.lightBlue,
                    )),
              ),
              SizedBox(height: 16.h),
            ]),
            SizedBox(height: 50.h),
            Hero(
              tag: 'signin_button',
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      email = _emailController.text;
                      password = _passwordController.text;
                    });
                    userLogin();
                  }
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
                      final gProvider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      gProvider.googleLogIn();
                      // SignUpStyle.gSignUp();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text("Don\'t have an account?"),
            SizedBox(height: 16.h),
            Hero(
              tag: 'signup_button',
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(_backSignUp());
                  clearText();
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
            // GestureDetector(
            //     onTap: () => Navigator.of(context).push(
            //       _backSignUp(),
            //     ),
            //     child: Text('Don\'t have an account? Sign Up')
            // ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }

  void clearText() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final SignUpStyle = Provider.of<PictureAdd>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.lightBlue),
                  ),
                );
              } else if (snapshot.hasData) {
                return Screens();
              } else if (snapshot.hasError) {
                return Container(
                    child: Center(child: Text("Something went wrong")));
              } else {
                return signInScreen();
              }
            }),
      ),
    );
  }
}

PageRouteBuilder _backSignUp() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Sign_up();
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

PageRouteBuilder _resetPassword() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return ResetPassword();
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
