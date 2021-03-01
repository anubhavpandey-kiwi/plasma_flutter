import 'package:flutter/material.dart';
import 'package:plasma_flutter/constants/app_fonts.dart';
import 'package:plasma_flutter/constants/app_strings.dart';
import 'package:plasma_flutter/ui/screens/search_screen.dart';
import 'package:plasma_flutter/ui/screens/settings_screen.dart';
import 'package:plasma_flutter/ui/screens/trending_screen.dart';
import 'package:plasma_flutter/ui/screens/watch_list.dart';

import '../colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = [
    TrendingScreen(),
    SearchScreen(),
    WatchList(),
    SettingsScreen()
  ];

  void _onItemTapped(int tappedIndex) {
    setState(() {
      _selectedIndex = tappedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          AppStrings.APP_NAME,
          style: TextStyle(
            fontSize: 30,
            foreground: Paint()..shader = AppColors.appGradient,
            fontFamily: AppFonts.TRUCULENTA,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: AppStrings.TRENDING,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: AppStrings.SEARCH,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later_outlined),
            label: AppStrings.WATCH_LIST,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: AppStrings.SETTINGS,
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
