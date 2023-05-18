import 'package:flutter/material.dart';
import 'package:learning_mvvm/model/user_model.dart';
import 'package:learning_mvvm/utils/routes/routes_name.dart';
import '../user_view_model.dart';

class SplashServices {
  // Concise way to define a getter method named "getUserData()" by calling the 
  // "getUser()" method from an instance of the "UserViewModel" class
  Future<UserModel> getUserData() async => await UserViewModel().getUser();

  void checkAuthentication(BuildContext context) {
    getUserData().then((value) async {
      if (value.token == "null" || value.token == "") {
        debugPrint(value.token);
        await Future.delayed(Duration(seconds: 3));
        await Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        await Future.delayed(Duration(seconds: 3));
        await Navigator.pushReplacementNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) => throw Exception(error.toString()));
  }
}
