import 'package:e_commerce/Firebase-Logic/CartProvider.dart';
import 'package:e_commerce/Firebase-Logic/GoogleSignInProvider.dart';
import 'package:e_commerce/Authentication/SpashScreen.dart';
import 'package:e_commerce/Constatnt/Utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(410, 890),
      builder: (BuildContext context, child){
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
            ChangeNotifierProvider(create: (context) => CartProvider()),
          ],
          child: MaterialApp(
              scaffoldMessengerKey: Utils.messengerKey,
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'E-Shop',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: SplashScreen(),
            ),
        );
      },
    );
  }
}
