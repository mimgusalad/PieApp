import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './style.dart' as style;
import './storage.dart' as store;
import 'dart:convert';
import 'dart:io';
import 'Pages/home.dart' as home;
import 'Pages/bookmark.dart' as bookmark;
import 'Pages/mypage.dart' as profile;
import 'Pages/succ.dart' as succ;
import 'Pages/message.dart' as message;

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c)=> store.UserStorage()),
          ChangeNotifierProvider(create: (c)=>store.ReviewStorage()),
          ChangeNotifierProvider(create: (c)=>store.SuccStorage()),
        ],
      child: MaterialApp(
        theme: style.theme,
        home: MyApp()
      )
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // 여기서부터 함수 등
  var tab = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<store.ReviewStorage>().getReviews();
    context.read<store.SuccStorage>().getArticles();
    context.read<store.ReviewStorage>().getMyReviews();
  }
  
  // 여기까지 함수 등
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.travel_explore), label: '방'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmarks_outlined), label: '북마크'),
          BottomNavigationBarItem(icon: Icon(Icons.sms_outlined), label: '메세지'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: '마이페이지'),
        ],
      ),
      body: [
        const home.Page(),
        const succ.Page(),
        const bookmark.Page(),
        message.Chat(),
        const profile.Page(),
      ][tab]
    );
  }
}
