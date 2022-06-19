import 'package:e_commerce/Top-Screens/Category/Full_Sleeve_Shirt.dart';
import 'package:e_commerce/Top-Screens/Category/Half_Sleeve_T-Shirt.dart';
import 'package:e_commerce/Top-Screens/Category/Lawn.dart';
import 'package:e_commerce/Top-Screens/Category/MensPunjabi.dart';
import 'package:e_commerce/Top-Screens/Category/Mens_Jacket_Sweater.dart';
import 'package:e_commerce/Top-Screens/Category/Organza.dart';
import 'package:e_commerce/Top-Screens/Category/Plain_T-Shirt.dart';
import 'package:e_commerce/Top-Screens/Category/Polo_T-Shirt.dart';
import 'package:e_commerce/Top-Screens/Category/Saree.dart';
import 'package:e_commerce/Top-Screens/Category/Track_Trouser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Half_Sleeve_Shirt.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
              imagePath: "assets/images/Half Sleeve Shirt.jpg",
              categoryName: "Men's Half Sleeve Shirt",
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HalfSleeveShirt())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Full Sleeve Shirt_2.jpg",
              categoryName: "Men's Full Sleeve Shirt",
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FullSleeveShirt())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Half Sleeve T-Shirt.jpg",
              categoryName: "Half Sleeve T-Shirt",
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
              imagePath: "assets/images/Mens_Jacket_Sweater.jpg",
              categoryName: "Men's Jacket & Sweater",
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MensJacketSweater())),
            ),
            // CategoryTemplate(
            //   imagePath: "assets/images/Hoodie.jpg",
            //   categoryName: "Men's Hoodie",
            //   onPressed: () => Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) => MensHoodie())),
            // ),
            CategoryTemplate(
              imagePath: "assets/images/Plain_T-Shirt.jpg",
              categoryName: "Plain T-Shirt",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => PlainTShirt())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Track Trousers.jpg",
              categoryName: "Track Trouser",
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TrackTrouser())),
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
                  .push(MaterialPageRoute(builder: (context) => MensPunjabi())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Ethnic-Suit.jpg",
              categoryName: "Women's Ethnic Suit",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MensPunjabi())),
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
              imagePath: "assets/images/Organza.jpg",
              categoryName: "Indian Chikankari",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Lawn())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Lawn.jpg",
              categoryName: "Women's Indian Jacquard",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Lawn())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Organza.jpg",
              categoryName: "Women's Pakistani Chiffon",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Lawn())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Tops.jpg",
              categoryName: "Women's Tops",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Lawn())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Womens-Sweater.jpg",
              categoryName: "Women's Sweater",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Lawn())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Kids-Punjabi.jpg",
              categoryName: "Kid's Punjabi",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Lawn())),
            ),
            CategoryTemplate(
              imagePath: "assets/images/Kids-Dress.jpg",
              categoryName: "Kid's Dresses",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Lawn())),
            ),
          ],
        ),
      ),
    );
  }
  // Card(
  // elevation: 4,
  // margin: EdgeInsets.all(15.w),

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
