import 'package:e_commerce/Authentication/Sign_in.dart';
import 'package:e_commerce/Top-Screens/Cart.dart';
import 'package:e_commerce/Top-Screens/Category/Category.dart';
import 'package:e_commerce/Top-Screens/HomeScreen.dart';
import 'package:e_commerce/Top-Screens/Profile/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  _ScreensState createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final padding = EdgeInsets.symmetric(horizontal: 20);
  bool _mensExpanded = false;
  bool _womensExpanded = false;
  bool _kidsExpanded = false;
  int index = 0;

  final Screens = [
    HomeScreen(),
    Category(),
    Cart(),
    Profile(),
  ];
  // int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final name = 'Tithi Rani Das';
    final email = 'tithiranidas99@gmail.com';
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      key: _scaffoldKey,
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
                              ListTile(
                                title: Text('Half Sleeve T-Shirt',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                              ),
                              ListTile(
                                title: Text('Full Sleeve T-Shirt',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                              ),
                              ListTile(
                                title: Text('Plain T-Shirt',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                              ),
                              ListTile(
                                title: Text('Hoodie',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                              ),
                              ListTile(
                                title: Text('Track Trouser',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                              ),
                              ListTile(
                                title: Text('Half Sleeve Shirt',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                              ),
                              ListTile(
                                title: Text('Full Sleeve Shirt',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
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
                              ListTile(
                                title: Text('Saree',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                title: Text('Ready Three-piece',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                title: Text('Unready Three-piece',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                                onTap: () {},
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
                              ListTile(
                                title: Text('Maggie',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                              ),
                              ListTile(
                                title: Text('Plain T-Shirt',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                              ),
                              ListTile(
                                title: Text('Full Sleeve T-Shirt',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                              ),
                              ListTile(
                                title: Text('Trouser',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                              ),
                              ListTile(
                                title: Text('Jeans Pant',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                title: Text('Half Sleeve Shirt',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                title: Text('Full Sleeve Shirt',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400)),
                                contentPadding: EdgeInsets.only(
                                  left: 40,
                                ),
                                onTap: () {},
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
                      onClicked: () {},
                    ),
                    buildMenuItem(
                      text: 'My Orders',
                      onClicked: () {},
                    ),
                    buildMenuItem(
                      text: 'Log Out',
                      onClicked: () async {
                        await FirebaseAuth.instance.signOut().then((value) =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Sign_in())));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // you can use silverAppBar with custom scroll view
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
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.grey.shade400,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
          ),
        ),
        child: NavigationBar(
            height: 65.h,
            backgroundColor: Color(0xfff7f6fb),
            //backgroundColor: Colors.white,
            animationDuration: Duration(seconds: 2),
            //labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.category_outlined),
                selectedIcon: Icon(Icons.category),
                label: 'Category',
              ),
              NavigationDestination(
                icon: Icon(Icons.add_shopping_cart_outlined),
                selectedIcon: Icon(Icons.add_shopping_cart),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle_outlined),
                selectedIcon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ]),
      ),
      body: Screens[index],
      // body: ScreenBody(),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  // Widget ScreenBody() {
  //   List<Widget> pages = [
  //     HomeScreen(),
  //     Category(),
  //     Cart(),
  //     Profile(),
  //   ];
  //   return IndexedStack(
  //     index: _currentIndex,
  //     children: pages,
  //   );
  // }

  // Widget _buildBottomNavigationBar(){
  //   return CustomAnimatedBottomBar(
  //     containerHeight: 60.h,
  //     backgroundColor: Colors.white,
  //     selectedIndex: _currentIndex,
  //     showElevation: true,
  //     itemCornerRadius: 24.r,
  //     curve: Curves.easeIn,
  //     onItemSelected: (index) => setState(() => _currentIndex = index),
  //     items: [
  //       BottomNavyBarItem(
  //         icon: Icon(Icons.home),
  //         title: Text('Home'),
  //         activeColor: Colors.lightBlue,
  //         inactiveColor: _inactiveColor,
  //         textAlign: TextAlign.center,
  //       ),
  //       BottomNavyBarItem(
  //         icon: Icon(Icons.category),
  //         title: Text('Categoy'),
  //         activeColor: Colors.lightBlue,
  //         inactiveColor: _inactiveColor,
  //         textAlign: TextAlign.center,
  //       ),
  //       BottomNavyBarItem(
  //         icon: Icon(Icons.add_shopping_cart),
  //         title: Text(
  //           'Cart',
  //         ),
  //         activeColor: Colors.lightBlue,
  //         inactiveColor: _inactiveColor,
  //         textAlign: TextAlign.center,
  //       ),
  //       BottomNavyBarItem(
  //         icon: Icon(Icons.account_circle),
  //         title: Text('Profile'),
  //         activeColor: Colors.lightBlue,
  //         inactiveColor: _inactiveColor,
  //         textAlign: TextAlign.center,
  //       ),
  //     ],
  //   );
  // }

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
                  backgroundImage: NetworkImage(path),
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

  Widget buildSearchField() {
    final color = Colors.black;
    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.black12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: Colors.lightBlue.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

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
}

// PageRouteBuilder _aboutUs() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return AboutUs();
//     },
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return SlideTransition(
//         position: Tween<Offset>(
//           begin: const Offset(1.0, 0.0),
//           end: const Offset(0.0, 0.0),
//         ).animate(animation),
//         child: child,
//       );
//     },
//     transitionDuration: const Duration(seconds: 1),
//     reverseTransitionDuration: const Duration(seconds: 1),
//   );
// }

PageRouteBuilder _buildScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Screens();
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

PageRouteBuilder _category() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Category();
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

PageRouteBuilder _cart() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Cart();
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

PageRouteBuilder _profile() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Profile();
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
