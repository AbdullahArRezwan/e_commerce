import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LawnDetailsPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const LawnDetailsPage({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  State<LawnDetailsPage> createState() => _LawnDetailsPageState();
}

class _LawnDetailsPageState extends State<LawnDetailsPage> {
  final List<String> sizeList = ["S", "M", "L", "XL", "XXL"];
  var currentSelected = 0;
  int _current = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  Future addToCart() async {
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("Users-Cart-Items");
    return _collectionRef
        .doc(currentUser!.uid)
        .collection("Items")
        .doc()
        .set({
      "Product-Name": widget.documentSnapshot["Product-Name"],
      "Product-Price": widget.documentSnapshot["Product-Price"],
      "Product-Image": widget.documentSnapshot["Product-Image"][0],
      "Product-Code": widget.documentSnapshot["Product-Code"],
      "Product-Quantity": int.parse("1"),
    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to cart successfully"))));
  }

  Future addToFavourite() async {
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("Users-Favourite-Items");
    return _collectionRef
        .doc(currentUser!.uid)
        .collection("Items")
        .doc()
        .set({
      "Product-Name": widget.documentSnapshot["Product-Name"],
      "Product-Price": widget.documentSnapshot["Product-Price"],
      "Product-Image": widget.documentSnapshot["Product-Image"][0],
      "Product-Code": widget.documentSnapshot["Product-Code"],
    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to wishlist successfully"))));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 30.w,
              ),
              child: Stack(
                children: [
                  Container(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Pakistani-Lawn")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return CarouselSlider(
                              items: widget.documentSnapshot["Product-Image"]
                                  .map<Widget>((item) => Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.r),
                                          ),
                                          child: Image.network(
                                            item,
                                            fit: BoxFit.cover,
                                            width: 1000,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.8,
                                  aspectRatio: 1,
                                  enableInfiniteScroll: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }));
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 25.w,
                      left: 15.w,
                      // right: 25.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.grey,
                                size: 20.w,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  widget.documentSnapshot["Product-Image"].map<Widget>((url) {
                int index =
                    widget.documentSnapshot["Product-Image"].indexOf(url);
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 3,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: _current == index
                          ? Colors.blue //Color.fromRGBO(0, 0, 0, 0.9)
                          : Colors.grey //Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                );
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                widget.documentSnapshot["Product-Name"],
                style: GoogleFonts.zenKurenaido(
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star_border_purple500),
                Icon(Icons.star_border_purple500),
                Icon(Icons.star_border_purple500),
                Icon(Icons.star_border_purple500),
                Icon(Icons.star_border_purple500),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Users-Favourite-Items").doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("Items").where("Product-Name",isEqualTo: widget.documentSnapshot['Product-Name']).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.data == null){
                      return Text("");
                    }
                    return GestureDetector(
                      onTap: () => snapshot.data.docs.length == 0 ? addToFavourite() : null,
                      child: snapshot.data.docs.length == 0 ? Row(
                        children: [
                          Text(
                            "Add to wishlist",
                            style: GoogleFonts.zenKurenaido(
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.favorite_outline,
                            size: 20.w,
                          ),
                        ],
                      ) : Row(
                        children: [
                          Text(
                            "Already added into wishlist",
                            style: GoogleFonts.zenKurenaido(
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.favorite_outlined,
                            size: 20.w,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              "Select Size",
              style: GoogleFonts.zenKurenaido(
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            Container(
              height: 60.h,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.w),
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      currentSelected = index;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                    decoration: BoxDecoration(
                        color: currentSelected == index
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.1),
                          width: 2,
                        )),
                    child: Text(
                      sizeList[index],
                      style: TextStyle(
                        color: currentSelected == index
                            ? Colors.white
                            : Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (_, index) => SizedBox(width: 10.w),
                itemCount: sizeList.length,
              ),
            ),
            Divider(
              height: 10.h,
              thickness: 1.w,
              color: Colors.grey,
              indent: 100,
              endIndent: 10,
            ),
            Text(
              "Description",
              style: GoogleFonts.zenKurenaido(
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            Divider(
              height: 20.h,
              thickness: 1.w,
              color: Colors.grey,
              indent: 10,
              endIndent: 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                widget.documentSnapshot["Product-Description"],
                style: GoogleFonts.zenKurenaido(
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              height: 20.h,
              thickness: 1.w,
              color: Colors.grey,
              indent: 10,
              endIndent: 10,
            ),
            // SizedBox(height: 10.h),
            Text(
              "Product Code: ${widget.documentSnapshot["Product-Code"]}",
              style: GoogleFonts.zenKurenaido(
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
                fontSize: 22.sp,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            // SizedBox(height: 10.h),
            Text(
              "Product Color: ${widget.documentSnapshot["Product-Color"]}",
              style: GoogleFonts.zenKurenaido(
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
                fontSize: 22.sp,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            Text(
              "Product Availability: ${widget.documentSnapshot["Product-Availability"]}",
              style: GoogleFonts.zenKurenaido(
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
                fontSize: 22.sp,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(25.w),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: GoogleFonts.zenKurenaido(
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "BDT ${widget.documentSnapshot["Product-Price"].toString()}",
                        style: GoogleFonts.zenKurenaido(
                          height: 1.5.h,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Container(
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: () => addToCart(),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          elevation: 2,
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add to Cart",
                              style: GoogleFonts.zenKurenaido(
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Icon(Icons.shopping_cart_outlined),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
