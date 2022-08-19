import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        iconTheme: IconThemeData(
          color: Colors.lightBlue,
        ),
        title: Text(
          "Wishlist",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 34.sp,
            fontWeight: FontWeight.w900,
            color: Colors.lightBlue,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.w),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users-Favourite-Items")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("Items")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Something is wrong"),
                );
              }
              return ListView.builder(
                  itemCount:
                  snapshot.data == null ? 0 : snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    DocumentSnapshot _documentSnapshot =
                    snapshot.data!.docs[index];
                    return Container(
                      height: 130.h,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Image.network(
                                _documentSnapshot["Product-Image"],
                                width: 100.w,
                                height: 120.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _documentSnapshot["Product-Name"],
                                    // style: Theme.of(context).textTheme.headline5,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "BDT ${_documentSnapshot["Product-Price"].toString()}",
                                              // style: Theme.of(context).textTheme.headline6,
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              _documentSnapshot["Product-Code"],
                                              // style: Theme.of(context).textTheme.headline6,
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("Users-Favourite-Items")
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .collection("Items")
                                              .doc(_documentSnapshot.id)
                                              .delete();
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
