import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Firebase-Logic/GoogleSignInProvider.dart';
import 'package:e_commerce/Top-Screens/Cart/Cart.dart';
import 'package:e_commerce/Top-Screens/Category/Category.dart';
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
import 'package:e_commerce/Top-Screens/Category/MensJacket&Sweater/MensJacketSweater.dart';
import 'package:e_commerce/Top-Screens/Category/MensPunjabi/MensPunjabi.dart';
import 'package:e_commerce/Top-Screens/Category/Organza/Organza.dart';
import 'package:e_commerce/Top-Screens/Category/PlainTShirt/PlainTShirt.dart';
import 'package:e_commerce/Top-Screens/Category/PoloTShirt/PoloTShirt.dart';
import 'package:e_commerce/Top-Screens/Category/Saree/Saree.dart';
import 'package:e_commerce/Top-Screens/Category/UnstitchedPrints/UnstitchedPrints.dart';
import 'package:e_commerce/Top-Screens/Category/WomensSweater/WomensSweater.dart';
import 'package:e_commerce/Top-Screens/Category/WomensTops/WomensTops.dart';
import 'package:e_commerce/Top-Screens/HomeScreen/ProductDetails.dart';
import 'package:e_commerce/Top-Screens/Profile/OrderHistory.dart';
import 'package:e_commerce/Top-Screens/Profile/Profile.dart';
import 'package:e_commerce/Top-Screens/Profile/WishList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Authentication/Sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final name = 'Tithi Rani Das';
  final email = 'tithiranidas99@gmail.com';
  final user = FirebaseAuth.instance.currentUser;
  final storage = new FlutterSecureStorage();
  bool _mensExpanded = false;
  bool _womensExpanded = false;
  bool _kidsExpanded = false;
  int _current = 0;

  List<String> CarouselImages = [
    "https://firebasestorage.googleapis.com/v0/b/e-shop-273fa.appspot.com/o/Carousel-Slider%2Fpexels-daian-gan-102129.jpg?alt=media&token=611946b9-7c76-4150-8ab5-3f9b90ef842c",
    "https://firebasestorage.googleapis.com/v0/b/e-shop-273fa.appspot.com/o/Carousel-Slider%2Fpexels-tembela-bohle-1884581.jpg?alt=media&token=084c2993-d661-4951-b845-929404dfde86",
    "https://firebasestorage.googleapis.com/v0/b/e-shop-273fa.appspot.com/o/Carousel-Slider%2Fpexels-tembela-bohle-1884583.jpg?alt=media&token=d4265702-421f-46d4-b96e-514cdbb189ba",
    "https://firebasestorage.googleapis.com/v0/b/e-shop-273fa.appspot.com/o/Carousel-Slider%2Fpexels-pixabay-264726.jpg?alt=media&token=5980578c-72c3-42ca-a0c9-e87522f3d645",
    "https://firebasestorage.googleapis.com/v0/b/e-shop-273fa.appspot.com/o/Carousel-Slider%2Fpexels-zhanzat-mamytova-1827130.jpg?alt=media&token=4b681d11-779b-4a4d-9c15-92889bf51e4c",
    "https://firebasestorage.googleapis.com/v0/b/e-shop-273fa.appspot.com/o/Carousel-Slider%2Fpexels-edgars-kisuro-1488463.jpg?alt=media&token=e8776f13-d493-4cbd-94fa-f75c32e803b7",
  ];

  List newArrivalsList = [];
  List popularProductsList = [];
  List flashSalesList = [];
  List fashionSalesList = [];
  List summerSalesList = [];

  newArrivalsProducts() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("New-Arrival").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        newArrivalsList.add({
          "Product-Name": qn.docs[i]["Product-Name"],
          "Product-Description": qn.docs[i]["Product-Description"],
          "Product-Price": qn.docs[i]["Product-Price"],
          "Product-Image": qn.docs[i]["Product-Image"],
          "Product-Code": qn.docs[i]["Product-Code"],
          "Product-Color": qn.docs[i]["Product-Color"],
          "Product-Availability": qn.docs[i]["Product-Availability"],
        });
      }
    });

    return qn.docs;
  }

  popularProducts() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("Popular-Product").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        popularProductsList.add({
          "Product-Name": qn.docs[i]["Product-Name"],
          "Product-Description": qn.docs[i]["Product-Description"],
          "Product-Price": qn.docs[i]["Product-Price"],
          "Product-Image": qn.docs[i]["Product-Image"],
          "Product-Code": qn.docs[i]["Product-Code"],
          "Product-Color": qn.docs[i]["Product-Color"],
          "Product-Availability": qn.docs[i]["Product-Availability"],
        });
      }
    });

    return qn.docs;
  }

  flashSales() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("New-Arrival").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        flashSalesList.add({
          "Product-Name": qn.docs[i]["Product-Name"],
          "Product-Description": qn.docs[i]["Product-Description"],
          "Product-Price": qn.docs[i]["Product-Price"],
          "Product-Image": qn.docs[i]["Product-Image"],
          "Product-Code": qn.docs[i]["Product-Code"],
          "Product-Color": qn.docs[i]["Product-Color"],
          "Product-Availability": qn.docs[i]["Product-Availability"],
        });
      }
    });

    return qn.docs;
  }

  fashionSales() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("Popular-Product").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        fashionSalesList.add({
          "Product-Name": qn.docs[i]["Product-Name"],
          "Product-Description": qn.docs[i]["Product-Description"],
          "Product-Price": qn.docs[i]["Product-Price"],
          "Product-Image": qn.docs[i]["Product-Image"],
          "Product-Code": qn.docs[i]["Product-Code"],
          "Product-Color": qn.docs[i]["Product-Color"],
          "Product-Availability": qn.docs[i]["Product-Availability"],
        });
      }
    });

    return qn.docs;
  }

  summerSales() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("New-Arrival").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        summerSalesList.add({
          "Product-Name": qn.docs[i]["Product-Name"],
          "Product-Description": qn.docs[i]["Product-Description"],
          "Product-Price": qn.docs[i]["Product-Price"],
          "Product-Image": qn.docs[i]["Product-Image"],
          "Product-Code": qn.docs[i]["Product-Code"],
          "Product-Color": qn.docs[i]["Product-Color"],
          "Product-Availability": qn.docs[i]["Product-Availability"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    newArrivalsProducts();
    popularProducts();
    flashSales();
    fashionSales();
    summerSales();
    super.initState();
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WishList())),
              child: Icon(Icons.favorite_outlined,
                  color: Colors.lightBlue, size: 30.w),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Material(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.only(
              left: 10,
            ),
            children: [
              buildHeader(
                // name: user.displayName!,
                // email: user.email!,
                // path: user.photoURL!,
                name: name,
                email: email,
                path: "assets/images/Hand_Pic.jpg",
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 16,
                ),
                child: Column(
                  children: [
                    Divider(
                      color: Colors.lightBlue,
                      thickness: 2,
                    ),
                    buildMenuItem(
                      text: 'Home',
                      // icon: Icons.home_outlined,
                      onClicked: () =>
                          Navigator.of(context).push(_buildScreen()),
                    ),
                    ExpansionPanelList(
                      elevation: 0.0,
                      animationDuration: Duration(milliseconds: 1000),
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return ListTile(
                              selectedTileColor: Colors.white,
                              selected: true,
                              title: Text(
                                'Mens',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              // leading: Icon(Icons.home_outlined, color: Colors.black,),
                            );
                          },
                          body: Column(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => MensPunjabi())),
                                child: ListTile(
                                  title: Text('Men\'s Punjabi',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HalfSleeveShirt())),
                                child: ListTile(
                                  title: Text('Short Sleeve Shirt',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FullSleeveShirt())),
                                child: ListTile(
                                  title: Text('Full Sleeve Shirt',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HalfSleeveTShirt())),
                                child: ListTile(
                                  title: Text('Short Sleeve T-Shirt',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => PoloTShirt())),
                                child: ListTile(
                                  title: Text('Polo T-Shirt',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => PlainTShirt())),
                                child: ListTile(
                                  title: Text('Plain T-Shirt',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MensJacketSweater())),
                                child: ListTile(
                                  title: Text('Jacket & Sweater',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isExpanded: _mensExpanded,
                          canTapOnHeader: true,
                        ),
                      ],
                      dividerColor: Colors.black,
                      expandedHeaderPadding: EdgeInsets.only(
                        top: 0.0,
                        bottom: 0.0,
                      ),
                      expansionCallback: (panelIndex, isExpanded) {
                        setState(() {
                          _mensExpanded = !_mensExpanded;
                        });
                      },
                    ),
                    ExpansionPanelList(
                      elevation: 0.0,
                      animationDuration: Duration(milliseconds: 1000),
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return ListTile(
                              selectedTileColor: Colors.white,
                              selected: true,
                              title: Text(
                                'Womens',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              //onTap: () => selectedItem(context, 5),
                            );
                          },
                          body: Column(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Saree())),
                                child: ListTile(
                                  title: Text('Saree',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => EthnicKurti())),
                                child: ListTile(
                                  title: Text('Ethnic Kurti',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => EthnicSuit())),
                                child: ListTile(
                                  title: Text('Ethnic Suit',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Organza())),
                                child: ListTile(
                                  title: Text('Pakistani Organza',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Lawn())),
                                child: ListTile(
                                  title: Text('Pakistani Lawn',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Chikankari())),
                                child: ListTile(
                                  title: Text('Indian Chikankari',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Jacquard())),
                                child: ListTile(
                                  title: Text('Indian Jacquard',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Chiffon())),
                                child: ListTile(
                                  title: Text('Pakistani Chiffon',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UnstitchedPrints())),
                                child: ListTile(
                                  title: Text('Unstitched Prints',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => WomensTops())),
                                child: ListTile(
                                  title: Text('Tops',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => WomensSweater())),
                                child: ListTile(
                                  title: Text('Sweater',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isExpanded: _womensExpanded,
                          canTapOnHeader: true,
                        ),
                      ],
                      dividerColor: Colors.black,
                      expandedHeaderPadding: EdgeInsets.only(
                        top: 0.0,
                        bottom: 0.0,
                      ),
                      expansionCallback: (panelIndex, isExpanded) {
                        _womensExpanded = !_womensExpanded;
                        setState(() {});
                      },
                    ),
                    //const SizedBox(height: 16),
                    ExpansionPanelList(
                      elevation: 0.0,
                      animationDuration: Duration(milliseconds: 1000),
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return ListTile(
                              selectedTileColor: Colors.white,
                              selected: true,
                              title: Text(
                                'Kids',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          body: Column(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => KidsPunjabi())),
                                child: ListTile(
                                  title: Text('Kid\'s Punjabi',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => KidsDress())),
                                child: ListTile(
                                  title: Text('Kid\'s Dress',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                  contentPadding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isExpanded: _kidsExpanded,
                          canTapOnHeader: true,
                        ),
                      ],
                      dividerColor: Colors.black,
                      expandedHeaderPadding: EdgeInsets.only(
                        top: 0.0,
                        bottom: 0.0,
                      ),
                      expansionCallback: (panelIndex, isExpanded) {
                        _kidsExpanded = !_kidsExpanded;
                        setState(() {});
                      },
                    ),
                    buildMenuItem(
                      text: 'My Wishlist',
                      onClicked: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => WishList())),
                    ),
                    buildMenuItem(
                      text: 'Order History',
                      onClicked: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => OrderHistory())),
                    ),
                    buildMenuItem(
                      text: 'Log Out',
                      onClicked: () async {
                        await storage.delete(key: "uid");
                        await FirebaseAuth.instance.signOut().then((value) =>
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Sign_in()),
                                (route) => false));
                        final gProvider =
                        Provider.of<GoogleSignInProvider>(context, listen: false);
                        gProvider.logOut();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 20.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 10.w,
                // borderRadius: BorderRadius.all(Radius.circular(15.r)),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                  height: 80.h,
                  width: double.infinity.w,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Explore",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "best Outfits for you",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Container(
                  height: 300.h,
                  child: CarouselSlider(
                      items: CarouselImages.map<Widget>((item) => Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                              child: Image.network(
                                item,
                                fit: BoxFit.fill,
                                width: double.infinity,
                              ),
                            ),
                          )).toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                          aspectRatio: 1.5,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          })),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: CarouselImages.map<Widget>((url) {
                  int index = CarouselImages.indexOf(url);
                  return Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 3,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: _current == index ? Colors.blue : Colors.grey),
                  );
                }).toList(),
              ),
              SizedBox(height: 15.w),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  "New Arrivals",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
              SizedBox(height: 10.w),
              Container(
                height: 450.w,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: newArrivalsList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 10.w,
                      crossAxisSpacing: 10.w,
                    ),
                    itemBuilder: (_, index) {
                      return buildCard(
                        image: newArrivalsList[index]["Product-Image"][0],
                        name: newArrivalsList[index]["Product-Name"],
                        price: newArrivalsList[index]["Product-Price"],
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                    product: newArrivalsList[index]))),
                      );
                    }),
              ),
              SizedBox(height: 20.w),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  "Popular Products",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
              SizedBox(height: 10.w),
              Container(
                height: 450.w,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularProductsList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.w,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 1.2),
                    itemBuilder: (_, index) {
                      return buildCard(
                        image: popularProductsList[index]["Product-Image"][0],
                        name: popularProductsList[index]["Product-Name"],
                        price: popularProductsList[index]["Product-Price"],
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                    product: popularProductsList[index]))),
                      );
                    }),
              ),
              SizedBox(height: 20.w),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  "Flash Sales",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
              SizedBox(height: 10.w),
              Container(
                height: 450.w,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: flashSalesList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 10.w,
                      crossAxisSpacing: 10.w,
                    ),
                    itemBuilder: (_, index) {
                      return buildCard(
                        image: flashSalesList[index]["Product-Image"][0],
                        name: flashSalesList[index]["Product-Name"],
                        price: flashSalesList[index]["Product-Price"],
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                    product: flashSalesList[index]))),
                      );
                    }),
              ),
              SizedBox(height: 20.w),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  "Fashion Sales",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
              SizedBox(height: 10.w),
              Container(
                height: 450.w,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: fashionSalesList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10.w,
                        crossAxisSpacing: 10.w,
                        crossAxisCount: 2,
                        childAspectRatio: 1.2),
                    itemBuilder: (_, index) {
                      return buildCard(
                        image: fashionSalesList[index]["Product-Image"][0],
                        name: fashionSalesList[index]["Product-Name"],
                        price: fashionSalesList[index]["Product-Price"],
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                    product: fashionSalesList[index]))),
                      );
                    }),
              ),
              SizedBox(height: 20.w),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  "Summer Sales",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
              SizedBox(height: 10.w),
              Container(
                height: 450.w,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: summerSalesList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10.w,
                      crossAxisSpacing: 10.w,
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                    ),
                    itemBuilder: (_, index) {
                      return buildCard(
                        image: summerSalesList[index]["Product-Image"][0],
                        name: summerSalesList[index]["Product-Name"],
                        price: summerSalesList[index]["Product-Price"],
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                    product: summerSalesList[index]))),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard({image, name, price, VoidCallback? onPressed}) {
    return Card(
      elevation: 10.w,
      child: Container(
          width: 200.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 2.5,
                    child: ClipRRect(
                      child: Material(
                        child: Ink.image(
                          image: NetworkImage(
                            image,
                          ),
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: onPressed,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  "BDT ${price.toString()}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget buildHeader({
    required String path,
    required String name,
    required String email,
    // required VoidCallback onClicked,
  }) =>
      InkWell(
        // onTap: onClicked,
        child: Container(
          padding: EdgeInsets.only(
            top: 50,
            bottom: 20,
          ),
          child: Column(
            children: [
              Container(
                width: 130.w,
                height: 130.h,
                // decoration: BoxDecoration(
                //   border: Border.all(width: 4.w, color: Colors.white),
                //   boxShadow: [
                //     BoxShadow(
                //         spreadRadius: 2.r,
                //         blurRadius: 10.r,
                //         color: Colors.black.withOpacity(0.1)
                //     )
                //   ],
                //   shape: BoxShape.circle,
                //   image: DecorationImage(
                //       fit: BoxFit.cover,
                //       image: AssetImage(path)),
                // ),
                child: CircleAvatar(
                  radius: 40.0,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  // child: ClipRRect(
                  //   // child: Image.asset("assets/images/Hand_Pic.jpg", width: 80.w, height: 80.h, fit: BoxFit.cover),
                  //   child: Image.asset("assets/images/add_photo.png", width: 70.w, height: 70.h, fit: BoxFit.cover),
                  //   borderRadius: BorderRadius.circular(40.0),
                  // ),
                  child: Image.asset(path),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                name,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(height: 4.h),
              Text(
                email,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      );

  buildMenuItem({
    required String text,
    // required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.lightBlue;
    final hoverColor = Colors.red;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.r),
        bottomLeft: Radius.circular(32.r),
      ),
      child: ListTile(
        // leading: Icon(icon, color: color),
        title: Text(text,
            style: TextStyle(
                color: color, fontSize: 17.sp, fontWeight: FontWeight.bold)),
        hoverColor: hoverColor,
        // selectedColor: Colors.black12,
        selected: true,
        onTap: onClicked,
      ),
    );
  }

  PageRouteBuilder _buildScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return HomeScreen();
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
}
