import 'package:flutter/cupertino.dart';

class PictureAdd extends ChangeNotifier{

  late final bool gPress;

  gSignUp() async{
    final bool gPress = true;
    notifyListeners();
  }
}