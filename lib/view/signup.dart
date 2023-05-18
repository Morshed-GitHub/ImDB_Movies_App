import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_mvvm/res/colors.dart';
import 'package:learning_mvvm/res/components/background_image.dart';
import 'package:learning_mvvm/res/components/frosted_glass_box.dart';
import 'package:learning_mvvm/res/components/round_button.dart';
import 'package:learning_mvvm/utils/routes/routes_name.dart';
import 'package:learning_mvvm/utils/utils.dart';
import 'package:learning_mvvm/view%20model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../res/components/check_circle_icon.dart';
import '../res/components/headline.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  // Provider
  ValueNotifier<bool> _obscurePass = ValueNotifier<bool>(true);
  ValueNotifier<bool> _obscureConfPass = ValueNotifier<bool>(true);

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmpasswordFocusNode = FocusNode();

  Map<String, dynamic> getUserCredentials() {
    return {
      "email": _emailController.text.trim().toString(),
      "password": _passwordController.text.trim().toString(),
    };
    // trim() method removes any leading (front) or trailing (back) spaces from user input before using it in the application
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmpasswordFocusNode.dispose();
    _obscurePass.dispose();
    _obscureConfPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    void TextFieldValidate() {
      if (_emailController.text.isEmpty) {
        Utils.snackBar("Email can't be empty!", context);
      } else if (!_emailController.text.contains("@")) {
        Utils.snackBar("Email must contain @", context);
      } else if (_passwordController.text.isEmpty) {
        Utils.snackBar("Password can't be empty!", context);
      } else if (_passwordController.text.length < 6) {
        Utils.snackBar("Password must be more than 6 letter's", context);
      } else if (_passwordController.text.toString() !=
          _confirmPasswordController.text.toString()) {
        Utils.snackBar("Both Password's must be same", context);
      } else {
        final _authViewModel =
            Provider.of<AuthViewModel>(context, listen: false);
        _authViewModel.signUpApi(getUserCredentials(), context);
      }
    }

    return WillPopScope(
      // Android User's can simply exit from app by pressing back button
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            BackgroundImage(),
            FrostedGlassBox(
              height: _height * .75,
              width: _width < 450 ? double.infinity : 480,
              child: signUp(_height, TextFieldValidate, context),
            ),
          ],
        ),
      ),
    );
  }

  Padding signUp(
      double _height, void TextFieldValidate(), BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CheckCircleIcon(),
          SizedBox(height: _height * .03),
          Headline(title: "Register"),
          SizedBox(height: _height * .04),
          email(),
          SizedBox(height: _height * .02),
          password(),
          SizedBox(height: _height * .02),
          confirmPassword(),
          SizedBox(height: _height * .05),
          Consumer<AuthViewModel>(
            builder: (context, value, child) {
              return RoundButton(
                  title: "Sign Up",
                  loading: value.signUpLoading,
                  onTap: () {
                    TextFieldValidate();
                  });
            },
          ),
          SizedBox(height: _height * .02),
          buildLoginQueryOption(context),
        ],
      ),
    );
  }

  Widget buildLoginQueryOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            color: AppColors.semiTransparentColor,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, RoutesName.login);
          },
          child: MouseRegion(
            cursor: SystemMouseCursors
                .click, // Icon changed when user hover over the container
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Login",
                style: TextStyle(
                  color: AppColors.buttonkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ValueListenableBuilder<bool> confirmPassword() {
    return ValueListenableBuilder(
      valueListenable: _obscureConfPass,
      builder: (context, value, child) {
        return TextField(
          controller: _confirmPasswordController,
          obscureText: value,
          obscuringCharacter: '#', // Password secured by showing -> #######
          focusNode: _confirmpasswordFocusNode,
          decoration: InputDecoration(
            hintText: "Confirm Password",
            prefixIcon: Icon(Icons.lock_open_outlined),
            suffixIcon: InkWell(
              onTap: () {
                _obscureConfPass.value = !_obscureConfPass.value;
              },
              child: Icon(
                _obscureConfPass.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
        );
      },
    );
  }

  ValueListenableBuilder<bool> password() {
    return ValueListenableBuilder(
      valueListenable: _obscurePass,
      builder: (context, value, child) {
        return TextField(
          controller: _passwordController,
          obscureText: value,
          obscuringCharacter: '#', // Password secured by showing -> #######
          focusNode: _passwordFocusNode,
          onSubmitted: (value) {
            // After submitting email, click done on keyboard, focus on the password bar
            Utils.changeFocusNode(context,
                current: _passwordFocusNode, next: _confirmpasswordFocusNode);
          },
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(Icons.lock_open_outlined),
            suffixIcon: InkWell(
              onTap: () {
                _obscurePass.value = !_obscurePass.value;
              },
              child: Icon(
                _obscurePass.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
        );
      },
    );
  }

  TextField email() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      focusNode: _emailFocusNode,
      onSubmitted: (value) {
        // After submitting email, click done on keyboard, focus on the password bar
        Utils.changeFocusNode(context,
            current: _emailFocusNode, next: _passwordFocusNode);
      },
      decoration: InputDecoration(
        hintText: "Email",
        prefixIcon: Icon(Icons.email_outlined),
      ),
    );
  }
}
