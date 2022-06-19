import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  String full_name = '';
  String phone = '';
  String email = '';
  String address = '';

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
          style: GoogleFonts.courgette( //zenKurenaido
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.none,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
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
              "Edit Profile",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30.h),
            TextFormField(
              // autofocus: true,
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
                } else {
                  return null;
                }
              },
              maxLength: 30,
              onSaved: (value) => setState(() => full_name = value!),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
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
                  return 'Enter a phone number';
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
                final pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                final regExp = RegExp(pattern);

                if (value!.isEmpty) {
                  return 'Enter an email';
                } else if (!regExp.hasMatch(value)) {
                  return 'Enter a valid email';
                } else {
                  return null;
                }
              },
              maxLength: 30,
              onSaved: (value) => setState(() => email = value!),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              // autofocus: true,
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
                  return 'Enter an address';
                }else {
                  return null;
                }
              },
              maxLength: 30,
              onSaved: (value) => setState(() => address = value!),
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


