import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Authentication/Sign_in.dart';
import 'package:e_commerce/Firebase-Logic/GoogleSignInProvider.dart';
import 'package:e_commerce/Top-Screens/Profile/ChangePassword.dart';
import 'package:e_commerce/Top-Screens/Profile/Edit_profile.dart';
import 'package:e_commerce/Top-Screens/Profile/OrderHistory.dart';
import 'package:e_commerce/Top-Screens/Profile/WishList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user = FirebaseAuth.instance.currentUser!;
  final storage = new FlutterSecureStorage();

  setDataToProfile(data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // child: Row(
        //   children: [
        //     CircleAvatar(
        //       // radius: 40.0,
        //       // foregroundColor: Colors.white,
        //       // backgroundColor: Colors.white,
        //       // // child: ClipRRect(
        //       // //   // child: Image.asset("assets/images/Hand_Pic.jpg", width: 80.w, height: 80.h, fit: BoxFit.cover),
        //       // //   child: Image.asset("assets/images/add_photo.png", width: 70.w, height: 70.h, fit: BoxFit.cover),
        //       // //   borderRadius: BorderRadius.circular(40.0),
        //       // // ),
        //       // backgroundImage: NetworkImage(user.photoURL!),
        //     ),
        //     SizedBox(width: 15.w),
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           // "Tithi Rani Das",
        //           user.displayName!,
        //           style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 20.sp,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         SizedBox(height: 10.h),
        //         Text(
        //           // "tithiranidas99@gmail.com",
        //           user.email!,
        //           style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 17.sp,
        //             fontWeight: FontWeight.normal,
        //           ),
        //         ),
        //       ],
        //     )
        //   ],
        // ),
        SizedBox(
          height: 160.h,
          width: 160.w,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 130.w,
                height: 130.h,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 4.w, color: Colors.lightBlue.withOpacity(0.7)),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2.r,
                        blurRadius: 10.r,
                        color: Colors.lightBlue.withOpacity(0.5))
                  ],
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Image.network(
                    data["ImageUrl"],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                right: 10, //-16
                bottom: -5,
                child: SizedBox(
                  height: 40.h, //46
                  width: 40.w, //46
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        side: BorderSide(
                            color: Colors.lightBlue.withOpacity(0.7),
                            width: 2.w),
                      ),
                      primary: Colors.white,
                      backgroundColor: Color(0xffefe6dc),
                      //backgroundColor: Color(0xff072A6C),
                    ),
                    onPressed: () {},
                    child: Icon(Icons.camera_alt_outlined,
                        size: 25.w, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          data["FullName"],
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.w),
        Text(
          data["Email"],
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 15.w),
        ProfileMenu(
          text: data["PhoneNumber"],
          leading_icon: Icons.call,
          tail_icon: null,
        ),
        ProfileMenu(
          text: data["Address"],
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
          text: "My Wishlist",
          leading_icon: Icons.favorite_outlined,
          press: () => {Navigator.of(context).push(_wishList())},
          tail_icon: Icons.arrow_forward_ios,
        ),
        ProfileMenu(
          text: "Order History",
          leading_icon: Icons.history,
          press: () => {Navigator.of(context).push(_orderList())},
          tail_icon: Icons.arrow_forward_ios,
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          child: SizedBox(
            width: double.infinity,
            height: 57.h,
            child: ElevatedButton(
              onPressed: () async {
                await storage.delete(key: "uid");
                await FirebaseAuth.instance.signOut().then((value) =>
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Sign_in())),
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Sign_in()),
                        (route) => false));
                final gProvider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                gProvider.logOut();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
    );
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
        title: Text(
          "E-Shop",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 34.sp,
            fontWeight: FontWeight.w900,
            color: Colors.lightBlue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 10.w),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("UserData")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Container(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.lightBlue)),
              );
            }
            return setDataToProfile(data);
          },
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

PageRouteBuilder _wishList() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return WishList();
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
      return OrderHistory();
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
