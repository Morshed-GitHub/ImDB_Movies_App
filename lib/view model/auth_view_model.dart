import 'package:flutter/material.dart';
import 'package:learning_mvvm/model/user_model.dart';
import 'package:learning_mvvm/repo/auth_repo.dart';
import 'package:learning_mvvm/utils/routes/routes_name.dart';
import 'package:learning_mvvm/utils/utils.dart';
import 'package:learning_mvvm/view%20model/user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  AuthRepo _authRepo = AuthRepo();

  UserViewModel _userViewModel = UserViewModel();

  bool _loginLoading = false;
  bool _signUpLoading = false;

  // Getter Methods
  bool get loginLoading => _loginLoading;
  bool get signUpLoading => _signUpLoading;

  // Setter Methods
  void setLoginLoading(bool newBool) {
    _loginLoading = newBool;
    notifyListeners();
  }

  void setSignUpLoading(bool newBool) {
    _signUpLoading = newBool;
    notifyListeners();
  }

// This function is responsible for handling the login API call.
// It takes two parameters:
// - data: The login data to be sent to the API.
// - context: The context of the current screen.
  Future loginApi(dynamic data, BuildContext context) async {
    // Set the login loading state to true to show the loading indicator.
    setLoginLoading(true);

    // Call the login API with the provided data.
    _authRepo.loginApi(data).then((value) async {
      // Once the API call is successful, set the login loading state to false.
      setLoginLoading(false);

      // Show a success message using a Snackbar.
      Utils.snackBar("Login Successful ✓", context);

      // Debug print the value returned by the API call.
      debugPrint(value.toString());

      // Save User Session with Shared_Preference
      await _userViewModel.setUser(UserModel(token: value["token"]));

      // Navigate to the home screen using the named route.
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      // If there's an error with the API call, set the login loading state to false.
      setLoginLoading(false);

      // Show an error message using a Snackbar.
      Utils.snackBar(error.toString(), context);

      // Debug print the error message.
      debugPrint(error.toString());
    });
  }

  signUpApi(dynamic data, BuildContext context) {
    setSignUpLoading(true);

    _authRepo.signUpApi(data).then((value) async {
      setSignUpLoading(false);

      Utils.snackBar("Sign Up Successful ✓", context);

      debugPrint(value.toString());

      await _userViewModel.setUser(UserModel(token: value["token"]));

      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setSignUpLoading(false);

      Utils.snackBar(error.toString(), context);

      debugPrint(error.toString());
    });
  }
}
