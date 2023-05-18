import 'package:flutter/material.dart';
import 'package:learning_mvvm/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  final String API_KEY = "token";

  Future setUser(UserModel user) async {
    final SharedPreferences SP = await SharedPreferences.getInstance();
    SP.setString(API_KEY, user.token.toString());
    notifyListeners();
  }

  Future<UserModel> getUser() async {
    final SharedPreferences SP = await SharedPreferences.getInstance();
    final String? token = SP.getString(API_KEY);

    return UserModel(token: token.toString());
  }

  Future removeUser() async {
    final SharedPreferences SP = await SharedPreferences.getInstance();
    SP.remove(API_KEY);
  }
}
