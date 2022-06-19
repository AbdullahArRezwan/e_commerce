import 'package:e_commerce/Firebase-Logic/GoogleSignInProvider.dart';
import 'package:e_commerce/Top-Screens/Profile/ChangePassword.dart';
import 'package:e_commerce/Top-Screens/Profile/Edit_profile.dart';
import 'package:e_commerce/Top-Screens/Profile/MyAllOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 10.w),
        child: Column(
          children: [
            Container(
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white,
                      // child: ClipRRect(
                      //   // child: Image.asset("assets/images/Hand_Pic.jpg", width: 80.w, height: 80.h, fit: BoxFit.cover),
                      //   child: Image.asset("assets/images/add_photo.png", width: 70.w, height: 70.h, fit: BoxFit.cover),
                      //   borderRadius: BorderRadius.circular(40.0),
                      // ),
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // "Tithi Rani Das",
                          user.displayName!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          // "tithiranidas99@gmail.com",
                          user.email!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ProfileMenu(
              text: "01715XXXXXX",
              leading_icon: Icons.call,
              tail_icon: null,
            ),
            ProfileMenu(
              text: "Ponitula, West Pathanthula, Sylhet",
              leading_icon: Icons.house,
              tail_icon: null,
            ),
            ProfileMenu(
              text: "Edit Profile",
              leading_icon: Icons.account_circle,
              press: () => {
                Navigator.of(context).push(
                  _editProfile(),
                )
              },
              tail_icon: Icons.arrow_forward_ios,
            ),
            ProfileMenu(
              text: "Change Password",
              leading_icon: Icons.lock,
              press: () => {Navigator.of(context).push(_changePassword())},
              tail_icon: Icons.arrow_forward_ios,
            ),
            ProfileMenu(
              text: "Order History",
              leading_icon: Icons.history,
              press: () => {Navigator.of(context).push(_orderList())},
              tail_icon: Icons.arrow_forward_ios,
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              child: SizedBox(
                width: double.infinity,
                height: 57.h,
                child: ElevatedButton(
                  onPressed: () async {
                    // await FirebaseAuth.instance.signOut().then((value)=>Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => Sign_in())));
                    final gProvider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    gProvider.logOut();
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    this.press,
    required this.leading_icon,
    this.tail_icon,
  }) : super(key: key);

  final String text;
  final IconData leading_icon;
  final VoidCallback? press;
  final tail_icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.w,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          backgroundColor: Color(0xffefe6dc),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              leading_icon,
              color: Colors.black,
              size: 25,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(tail_icon),
          ],
        ),
      ),
    );
  }
}

PageRouteBuilder _editProfile() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return EditProfile();
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

PageRouteBuilder _changePassword() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return ChangePassword();
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

PageRouteBuilder _orderList() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return MyAllOrder();
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
