import 'package:flutter/material.dart';

var theme = ThemeData(
  useMaterial3: true,
    iconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 25)
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.black,
    )
);