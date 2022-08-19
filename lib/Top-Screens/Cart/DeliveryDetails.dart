import 'package:e_commerce/Top-Screens/Cart/PaymentDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({Key? key}) : super(key: key);

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  final formKey = GlobalKey<FormState>();
  String name = "";
  String phone = "";
  String address = "";
  String notes = "";
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _addressController;
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
          "Delivery Details",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 34.sp,
            fontWeight: FontWeight.w900,
            color: Colors.lightBlue,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                  "Please give us your correct information for product deliver to you.",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.w),
              TextFormField(
                autofocus: false,
                controller: _nameController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
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
                onSaved: (value) => setState(() => name = value!),
              ),
              SizedBox(height: 15.w),
              TextFormField(
                autofocus: false,
                controller: _phoneController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Phone Number",
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
              SizedBox(height: 15.w),
              TextFormField(
                autofocus: false,
                controller: _addressController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  labelText: "Address",
                  hintText: "Address",
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
              SizedBox(height: 15.w),
              TextField(
                autofocus: false,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  labelText: "Notes (optional)",
                  hintText: "Notes",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(10.r)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(10.r)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(10.r)),
                ),
                maxLines: 6,
                maxLength: 300,
                onChanged: (value) => setState(() => notes = value),
              ),
              SizedBox(height: 50.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios_new_outlined, size: 15.w),
                    label: Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(170.w, 50.h),
                        primary: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        )
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: (){
                      final isValid = formKey.currentState!.validate();

                      if (isValid) {
                        formKey.currentState!.save();
                        // updateData();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentDetails()));
                      }
                    },
                    icon: Icon(Icons.payment_outlined),
                    label: Text(
                      "Make Payment",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(170.w, 50.h),
                        primary: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
