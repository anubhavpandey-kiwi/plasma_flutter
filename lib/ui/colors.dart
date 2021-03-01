
import 'package:flutter/material.dart';

class AppColors{
  AppColors._();

  static Shader appGradient = LinearGradient(colors: <Color>[Colors.teal[200], Color(0xFF56bee0), Colors.blue[200]]).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

}