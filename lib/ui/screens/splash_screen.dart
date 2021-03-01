import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plasma_flutter/constants/app_strings.dart';
import 'package:plasma_flutter/constants/routes.dart';

import '../colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const int _SPLASH_TIME = 1;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: _SPLASH_TIME),
        () => {Navigator.popAndPushNamed(context, Routes.HOME_SCREEN)});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            AppStrings.APP_NAME,
            style: TextStyle(
              fontSize: 40,
              foreground: Paint()..shader = AppColors.appGradient,
            ),
          ),
        ),
      ),
    );
  }
}
