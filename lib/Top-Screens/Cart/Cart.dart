import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Firebase-Logic/CartProvider.dart';
import 'package:e_commerce/Top-Screens/Cart/CartDetails.dart';
import 'package:e_commerce/Top-Screens/Cart/DeliveryDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int quantity = 1;
  bool isTrue = true;
  var totalPrice = 0.0;
  var temp = 0.0;

  changeTotalPrice(int price, bool increase) {
    if (increase) {
      totalPrice += price;
      print(price);
      print(
          "9jjnnnngjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjhnnnnnn00000111111111111");
    } else {
      totalPrice -= price;
      print(price);
      print("9jjnnnngjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjhnnnnnn");
    }
    Provider.of<CartProvider>(context,listen: false).reloadTotalPrice();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context,listen: false).reloadTotalPrice();
    });
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.w),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users-Cart-Items")
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
              return ListView(
                children: [
                  ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data == null
                          ? 0
                          : snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];
                        totalPrice += (_documentSnapshot["Product-Price"] *
                            _documentSnapshot["Product-Quantity"]);
                        // if(index==snapshot.data!.docs.length-1){
                        //   Provider.of<CartProvider>(context,listen: false).reloadTotalPrice();
                        // }
                        return CartProductCard(
                          ProductName: _documentSnapshot["Product-Name"],
                          ProductPrice: _documentSnapshot["Product-Price"],
                          ProductImage: _documentSnapshot["Product-Image"],
                          ProductCode: _documentSnapshot["Product-Code"],
                          ProductQuantity:
                              _documentSnapshot["Product-Quantity"],
                          ProductId: _documentSnapshot.id,
                          calculate: changeTotalPrice,
                        );
                        int itemQuantity =
                            _documentSnapshot["Product-Quantity"];
                        // return Container(
                        //   height: 130.h,
                        //   width: double.infinity,
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: 10.w),
                        //     child: Row(
                        //       children: [
                        //         ClipRRect(
                        //           borderRadius: BorderRadius.circular(15.r),
                        //           child: Image.network(
                        //             _documentSnapshot["Product-Image"],
                        //             width: 100.w,
                        //             height: 120.h,
                        //             fit: BoxFit.fill,
                        //           ),
                        //         ),
                        //         SizedBox(width: 10.w),
                        //         Expanded(
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 _documentSnapshot["Product-Name"],
                        //                 // style: Theme.of(context).textTheme.headline5,
                        //                 style: TextStyle(
                        //                   fontSize: 18.sp,
                        //                   fontWeight: FontWeight.bold,
                        //                 ),
                        //               ),
                        //               SizedBox(height: 10.h),
                        //               Row(
                        //                 children: [
                        //                   Expanded(
                        //                     child: Column(
                        //                       crossAxisAlignment: CrossAxisAlignment.start,
                        //                       children: [
                        //                         Text(
                        //                           "BDT ${_documentSnapshot["Product-Price"].toString()}",
                        //                           // style: Theme.of(context).textTheme.headline6,
                        //                           style: TextStyle(
                        //                             fontSize: 17.sp,
                        //                             fontWeight: FontWeight.normal,
                        //                           ),
                        //                         ),
                        //                         SizedBox(height: 5.h),
                        //                         Text(
                        //                           _documentSnapshot["Product-Code"],
                        //                           // style: Theme.of(context).textTheme.headline6,
                        //                           style: TextStyle(
                        //                             fontSize: 17.sp,
                        //                             fontWeight: FontWeight.normal,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       IconButton(
                        //                         onPressed: () {
                        //                           if (itemQuantity == 1) {
                        //                             setState(() {
                        //                               isTrue = false;
                        //                               totalPrice += _documentSnapshot["Product-Price"];
                        //                             });
                        //                           } else if (itemQuantity > 1) {
                        //                             setState(() {
                        //                               itemQuantity--;
                        //                               totalPrice -= _documentSnapshot["Product-Price"];
                        //                             });
                        //                           }
                        //                           // setState((){
                        //                           //
                        //                           // });
                        //                         },
                        //                         icon: Icon(Icons.remove_circle),
                        //                       ),
                        //                       Text(
                        //                         "$itemQuantity",
                        //                         style: Theme.of(context).textTheme.headline5,
                        //                       ),
                        //                       IconButton(
                        //                         onPressed: () {
                        //                           if(itemQuantity>=1){
                        //                             setState(() {
                        //                               quantity++;
                        //                               totalPrice += _documentSnapshot["Product-Price"];
                        //                             });
                        //                           }
                        //                         },
                        //                         icon: Icon(Icons.add_circle),
                        //                       ),
                        //                       IconButton(
                        //                         onPressed: () {
                        //                           FirebaseFirestore.instance
                        //                               .collection("Users-Cart-Items")
                        //                               .doc(FirebaseAuth.instance.currentUser!.uid)
                        //                               .collection("Items")
                        //                               .doc(_documentSnapshot.id)
                        //                               .delete();
                        //                         },
                        //                         icon: Icon(Icons.delete),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ],
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // );
                      }),
                  SizedBox(height: 20.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50.h,
                        width: 170.w,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                        ),
                        child: Center(
                          child: Consumer<CartProvider>(
                            builder: (_ , __, ___) => Text(
                              "Total Price: $totalPrice",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => DeliveryDetails())),
                        icon: Icon(Icons.shopping_cart_checkout_outlined),
                        label: Text(
                          "Checkout",
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
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.w),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
