import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_mvvm/res/colors.dart';
import 'package:learning_mvvm/view%20model/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices _splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    _splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 200,
            ),
            SizedBox(height: _height * .08),
            SpinKitWaveSpinner(
              color: AppColors.buttonkColor.withOpacity(.6),
              trackColor: AppColors.buttonkColor.withOpacity(.4),
              duration: Duration(seconds: 3),
              curve: Curves.fastOutSlowIn,
              waveColor: AppColors.buttonkColor,
            )
          ],
        ),
      ),
    );
  }
}
