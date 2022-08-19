import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  String fullName = '';
  String phone = '';
  String email = '';
  String address = '';
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _emailController;
  TextEditingController? _addressController;

  String? imagePath;
  String? imageName;
  bool isLoading = false;
  bool isPicked = false;
  final ImagePicker imagePicker = ImagePicker();
  String downloadUrl = "";
  FirebaseStorage storageRef = FirebaseStorage.instance;

  Future getImage() async {
    try {
      final XFile? pickImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickImage != null) {
        setState(() {
          imagePath = pickImage.path;
          imageName = pickImage.name;
          isPicked = true;
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> uploadImage(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      final result =
          await storageRef.ref("UserProfilePic/$fileName").putFile(file);
      downloadURL(result);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String?> downloadURL(TaskSnapshot value) async {
    // downloadUrl = await storageRef.ref("UserProfilePic/$imageName").getDownloadURL();
    downloadUrl = await value.ref.getDownloadURL();
    updateDataWithImage(downloadUrl);
    print(downloadUrl);
    return downloadUrl;
  }

  updateDataWithImage(downloadUrl) {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("UserData");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "FullName": _nameController!.text,
      "Email": _emailController!.text,
      "PhoneNumber": _phoneController!.text,
      "Address": _addressController!.text,
      "ImageUrl": downloadUrl,
    });
  }

  updateDataWithoutImage() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("UserData");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "FullName": _nameController!.text,
      "Email": _emailController!.text,
      "PhoneNumber": _phoneController!.text,
      "Address": _addressController!.text,
    });
  }

  setDataToTextFormField(data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: formKey,
        child: Column(
          children: [
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
                        child: (imagePath == null)
                            ? Image.network(data["ImageUrl"], fit: BoxFit.fill)
                            : imagePath!.contains("http")
                                ? Image.network(
                                    imagePath!,
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(
                                    File(imagePath!),
                                    fit: BoxFit.fill,
                                  )),
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
                        onPressed: () => getImage(),
                        child: Icon(Icons.camera_alt_outlined,
                            size: 25.w, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40.h),
            TextFormField(
              // autofocus: true,
              controller: _nameController =
                  TextEditingController(text: data["FullName"]),
              keyboardType: TextInputType.text,
              // initialValue: data[],
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
                prefixIcon: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Text(
                    "Full Name",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
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
              // autofocus: true,
              controller: _phoneController =
                  TextEditingController(text: data["PhoneNumber"]),
              // initialValue: data[],
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
                prefixIcon: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Text(
                    "Phone",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
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
              // autofocus: true,
              controller: _emailController =
                  TextEditingController(text: data["Email"]),
              // initialValue: data[],
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
                prefixIcon: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              validator: (value) {
                final pattern =
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                final regExp = RegExp(pattern);

                if (value!.isEmpty) {
                  return 'Enter your email';
                } else if (!regExp.hasMatch(value)) {
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
              // autofocus: true,
              controller: _addressController =
                  TextEditingController(text: data["Address"]),
              // initialValue: data["Address"],
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
                prefixIcon: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Text(
                    "Address",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
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
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: SizedBox(
                width: double.infinity,
                height: 57.h,
                child: ElevatedButton(
                  onPressed: () {
                    final isValid = formKey.currentState!.validate();

                    if (isValid) {
                      formKey.currentState!.save();
                      if (isPicked) {
                        uploadImage(imagePath!, imageName!);
                      } else {
                        updateDataWithoutImage();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Profile successfully updated")));
                      Navigator.pop(context);
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
          "Edit Profile",
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
        child: Container(
          child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      SizedBox(height: 40.w),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("UserData")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          var data = snapshot.data;
                          if (data == null) {
                            return Center(
                                child: CircularProgressIndicator(
                                    color: Colors.lightBlue));
                          }
                          return setDataToTextFormField(data);
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
  // Widget buildUsername() => TextFormField(
  //   decoration: InputDecoration(
  //     prefixIcon: Padding(padding: EdgeInsets.all(15), child: Text("Usrname")),
  //     hintText: "Username",
  //     border: OutlineInputBorder(),
  //     // errorBorder:
  //     //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
  //     // focusedErrorBorder:
  //     //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
  //     // errorStyle: TextStyle(color: Colors.purple),
  //   ),
  //   validator: (value) {
  //     if (value!.length < 4) {
  //       return 'Enter at least 4 characters';
  //     } else {
  //       return null;
  //     }
  //   },
  //   maxLength: 30,
  //   onSaved: (value) => setState(() => firstname = value!),
  // );
  //
  // Widget buildEmail() => TextFormField(
  //   decoration: InputDecoration(
  //     prefixIcon: Padding(padding: EdgeInsets.all(15), child: Text("Email")),
  //     hintText: 'Email',
  //     border: OutlineInputBorder(),
  //   ),
  //   validator: (value) {
  //     final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
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
  //   keyboardType: TextInputType.emailAddress,
  //   onSaved: (value) => setState(() => email = value!),
  // );
  //
  // Widget buildPassword() => TextFormField(
  //   decoration: InputDecoration(
  //     prefixIcon: Padding(padding: EdgeInsets.all(15), child: Text("password")),
  //     hintText: 'Password',
  //     border: OutlineInputBorder(),
  //   ),
  //   validator: (value) {
  //     if (value!.length < 7) {
  //       return 'Password must be at least 7 characters long';
  //     } else {
  //       return null;
  //     }
  //   },
  //   onSaved: (value) => setState(() => password = value!),
  //   keyboardType: TextInputType.visiblePassword,
  //   obscureText: true,
  // );

  // Widget buildSubmit() => Builder(
  //   builder: (context) => ButtonWidget(
  //     text: 'Submit',
  //     onClicked: () {
  //       final isValid = formKey.currentState!.validate();
  //       // FocusScope.of(context).unfocus();
  //
  //       if (isValid) {
  //         formKey.currentState!.save();
  //
  //         final message =
  //             'Username: $username\nPassword: $password\nEmail: $email';
  //         final snackBar = SnackBar(
  //           content: Text(
  //             message,
  //             style: TextStyle(fontSize: 20),
  //           ),
  //           backgroundColor: Colors.green,
  //         );
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       }
  //     },
  //   ),
  // );
}
