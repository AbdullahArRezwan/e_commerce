import 'package:e_commerce/Top-Screens/Category/Chiffon/Chiffon.dart';
import 'package:e_commerce/Top-Screens/Category/Chikankari/Chikankari.dart';
import 'package:e_commerce/Top-Screens/Category/EthnicKurti/EthnicKurti.dart';
import 'package:e_commerce/Top-Screens/Category/EthnicSuit/EthnicSuit.dart';
import 'package:e_commerce/Top-Screens/Category/FullSleeveShirt/FullSleeveShirt.dart';
import 'package:e_commerce/Top-Screens/Category/HalfSleeveShirt/HalfSleeveShirt.dart';
import 'package:e_commerce/Top-Screens/Category/HalfSleeveTShirt/HalfSleeveTShirt.dart';
import 'package:e_commerce/Top-Screens/Category/Jacquard/Jacquard.dart';
import 'package:e_commerce/Top-Screens/Category/KidsDress/KidsDress.dart';
import 'package:e_commerce/Top-Screens/Category/KidsPunjabi/KidsPunjabi.dart';
import 'package:e_commerce/Top-Screens/Category/Lawn/Lawn.dart';
import 'package:e_commerce/Top-Screens/Category/MensPunjabi/MensPunjabi.dart';
import 'package:e_commerce/Top-Screens/Category/MensJacket&Sweater/MensJacketSweater.dart';
import 'package:e_commerce/Top-Screens/Category/Organza/Organza.dart';
import 'package:e_commerce/Top-Screens/Category/PlainTShirt/PlainTShirt.dart';
import 'package:e_commerce/Top-Screens/Category/PoloTShirt/PoloTShirt.dart';
import 'package:e_commerce/Top-Screens/Category/Saree/Saree.dart';
import 'package:e_commerce/Top-Screens/Category/UnstitchedPrints/UnstitchedPrints.dart';
import 'package:e_commerce/Top-Screens/Category/WomensSweater/WomensSweater.dart';
import 'package:e_commerce/Top-Screens/Category/WomensTops/WomensTops.dart';
import 'package:e_commerce/Top-Screens/Profile/WishList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        // iconTheme: IconThemeData(
        //   color: Colors.lightBlue,
        // ),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Color(0xfff7f6fb),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.lightBlue,
                )),
          ),
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WishList())),
              child: Icon(Icons.favorite_outlined, color: Colors.lightBlue, size: 30.w),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 10.w,
        ),
        child: Column(
          children: [
            CategoryTemplate(
              imagePath: "assets/images/Mens_Punjabi.jpg",
              categoryName: "Men's Punjabi",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MensPunjabi())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/ShortSleeveShirt.jpg",
              categoryName: "Men's Short Sleeve Shirt",
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HalfSleeveShirt())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/FullSleeveShirt.jpg",
              categoryName: "Men's Full Sleeve Shirt",
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FullSleeveShirt())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/HalfSleeveTShirt.jpg",
              categoryName: "Men's Short Sleeve T-Shirt",
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HalfSleeveTShirt())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Polo_T-Shirt.jpg",
              categoryName: "Men's Polo T-Shirt",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => PoloTShirt())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/PlainTShirt.jpg",
              categoryName: "Men's Plain T-Shirt",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => PlainTShirt())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Mens_Jacket_Sweater.jpg",
              categoryName: "Men's Jacket & Sweater",
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MensJacketSweater())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/saree.jpg",
              categoryName: "Women's Saree",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Saree())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Ethnic-Kurti.jpg",
              categoryName: "Women's Ethnic Kurti",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EthnicKurti())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Ethnic-Suit.jpg",
              categoryName: "Women's Ethnic Suit",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EthnicSuit())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Organza.jpg",
              categoryName: "Women's Pakistani Organza",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Organza())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Lawn.jpg",
              categoryName: "Women's Pakistani Lawn",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Lawn())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Chikankari.jpg",
              categoryName: "Women's Indian Chikankari",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Chikankari())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Jacquard.jpg",
              categoryName: "Women's Indian Jacquard",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Jacquard())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Chiffon.jpg",
              categoryName: "Women's Pakistani Chiffon",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Chiffon())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/UnstitchedPrints.jpg",
              categoryName: "Women's Unstitched Prints",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UnstitchedPrints())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Tops.jpg",
              categoryName: "Women's Tops",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WomensTops())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Womens-Sweater.jpg",
              categoryName: "Women's Sweater",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WomensSweater())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Kids-Punjabi.jpg",
              categoryName: "Kid's Punjabi",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => KidsPunjabi())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Kids-Dress.jpg",
              categoryName: "Kid's Dresses",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => KidsDress())),
            ),
          ],
        ),
      ),
    );
  }

  CategoryTemplate({
    required String imagePath,
    required String categoryName,
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
          ),
          height: 330.h,
          // margin: EdgeInsets.all(15.w),
          child: Stack(
            children: [
              Ink.image(
                image: AssetImage(imagePath),
                height: 330.h,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                child: InkWell(
                  onTap: onPressed,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  width: 225.w,
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(
                    vertical: 5.w,
                    horizontal: 20.w,
                  ),
                  child: Text(
                    categoryName,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.zenKurenaido(
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
