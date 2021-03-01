import 'package:flutter/material.dart';
import 'package:plasma_flutter/ui/screens/home_screen.dart';
import 'package:plasma_flutter/ui/screens/movie_detail_screen.dart';
import 'package:plasma_flutter/ui/screens/splash_screen.dart';

import 'constants/app_fonts.dart';
import 'constants/app_strings.dart';
import 'constants/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.tealAccent,
          brightness: Brightness.dark,
          fontFamily: AppFonts.TRUCULENTA),
      initialRoute: Routes.SPLASH_SCREEN,
      routes: {
        Routes.SPLASH_SCREEN: (context) => SplashScreen(),
        Routes.HOME_SCREEN: (context) => HomeScreen(),
        Routes.MOVIE_DETAIL_SCREEN: (context) => MovieDetailScreen(),
      },
    );
  }
}
