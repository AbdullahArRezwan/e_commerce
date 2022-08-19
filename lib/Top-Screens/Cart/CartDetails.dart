import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Firebase-Logic/CartProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartProductCard extends StatefulWidget {
  final String ProductName;
  final int ProductPrice;
  final String ProductCode;
  final String ProductImage;
  final String ProductId;
  late int ProductQuantity;
  Function calculate;
  CartProductCard(
      {Key? key,
      required this.ProductName,
      required this.ProductPrice,
      required this.ProductCode,
      required this.ProductImage,
      required this.ProductId,
      required this.ProductQuantity,
        required this.calculate,
      })
      : super(key: key);

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  int quantity = 1;
  bool isTrue = true;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    quantity = widget.ProductQuantity;
  }

  @override
  Widget build(BuildContext context) {
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
    //             widget.ProductImage,
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
    //                 widget.ProductName,
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
    //                           "BDT ${widget.ProductPrice.toString()}",
    //                           // style: Theme.of(context).textTheme.headline6,
    //                           style: TextStyle(
    //                             fontSize: 17.sp,
    //                             fontWeight: FontWeight.normal,
    //                           ),
    //                         ),
    //                         SizedBox(height: 5.h),
    //                         Text(
    //                           widget.ProductCode,
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
    //                           if (quantity == 1) {
    //                             setState(() {
    //                               isTrue = false;
    //                             });
    //                           } else if (quantity > 1) {
    //                             setState(() {
    //                               quantity--;
    //                             });
    //                           }
    //                           // setState((){
    //                           //
    //                           // });
    //                         },
    //                         icon: Icon(Icons.remove_circle),
    //                       ),
    //                       Text(
    //                         "$quantity",
    //                         style: Theme.of(context).textTheme.headline5,
    //                       ),
    //                       IconButton(
    //                         onPressed: () {
    //                           setState(() {
    //                             quantity++;
    //                           });
    //                         },
    //                         icon: Icon(Icons.add_circle),
    //                       ),
    //                       IconButton(
    //                         onPressed: () {
    //                           FirebaseFirestore.instance
    //                               .collection("Users-Cart-Items")
    //                               .doc(FirebaseAuth.instance.currentUser!.uid)
    //                               .collection("Items")
    //                               .doc(widget.ProductId)
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
    Provider.of<CartProvider>(context,listen: false).reloadTotalPrice();
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
                widget.ProductImage,
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
                    widget.ProductName,
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
                              "BDT ${widget.ProductPrice.toString()}",
                              // style: Theme.of(context).textTheme.headline6,
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              widget.ProductCode,
                              // style: Theme.of(context).textTheme.headline6,
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity == 1) {
                                setState(() {
                                  isTrue = false;
                                });
                              } else if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                  // totalPrice -= widget.ProductPrice;
                                  widget.calculate(widget.ProductPrice, false);
                                });
                              }
                              // setState((){
                              //
                              // });
                            },
                            icon: Icon(Icons.remove_circle),
                          ),
                          Text(
                            quantity.toString(),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                                // totalPrice += widget.ProductPrice;
                                widget.calculate(widget.ProductPrice, true);
                              });
                            },
                            icon: Icon(Icons.add_circle),
                          ),
                          IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("Users-Cart-Items")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("Items")
                                  .doc(widget.ProductId)
                                  .delete();
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
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

  }
}
