import 'package:e_commerce/Authentication/Sign_in.dart';
import 'package:e_commerce/Top-Screens/Cart/Cart.dart';
import 'package:e_commerce/Top-Screens/Category/Category.dart';
import 'package:e_commerce/Top-Screens/HomeScreen/HomeScreen.dart';
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

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // you can use silverAppBar with custom scroll view
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
            animationDuration: Duration(seconds: 2),
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

