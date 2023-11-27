import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:get/get.dart';
import './style.dart' as style;
import 'Storage/image_storage.dart';
import 'Storage/review_storage.dart';
import 'Storage/succ_storage.dart';
import 'Storage/favorite_storage.dart';
import 'Pages/home.dart' as home;
import 'Pages/favorite.dart' as bookmark;
import 'Pages/mypage.dart' as profile;
import 'Pages/succ.dart' as succ;
import 'Pages/message_list.dart' as message;
import 'Components/message.dart';
import 'Components/review_detail.dart' as reviewDetail;
import 'Components/succ_detail.dart' as succDetail;
import 'package:http/http.dart' as http;

const APP_ID = '4E4C060D-17A6-4CC6-84EA-47D1C87A1F43';
const API_TOKEN = '1d5127c511ce2b3d1e1f27bde93727381958dc63';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SendbirdChat.init(appId: APP_ID);
  // 현재 접속한 사람 userId
  var user = await SendbirdChat.connect('seohyunbin1@naver.com',
      accessToken: API_TOKEN);
  if (user.nickname.isEmpty) {
    var res = await http.put(
        Uri.parse('https://api-$APP_ID.sendbird.com/v3/users/${user.userId}'),
        headers: {'Content-Type': 'application/json', 'Api-Token': API_TOKEN},
        body: jsonEncode({
          // 현재 접속한 사람 닉네임
          'nickname': '서현빈',
        }));
    debugPrint(res.body);
  }

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => ReviewStorage()),
          ChangeNotifierProvider(create: (c) => SuccStorage()),
          ChangeNotifierProvider(create: (c) => ImageStorage()),
          ChangeNotifierProvider(create: (c) => FavoriteStorage()),
        ],
        child: GetMaterialApp(
          theme: style.theme,
          home: const MyApp(),
          getPages: [
            // GetPage(name: '/home', page: ()=> home.Page()),
            // GetPage(name: '/bookmark', page: ()=> bookmark.Page()),
            // GetPage(name: '/profile', page: ()=> profile.Page()),
            // GetPage(name: '/succ', page: ()=> succ.Page()),
            // GetPage(name: '/message', page: ()=> message.ChannelList()),
            GetPage(name: '/succ_detail',
                page: () => const succDetail.Page()
            ),
            GetPage(
                name: '/review_detail',
                page: () => reviewDetail.Page()),
            GetPage(
              name: '/group_channel/:channel_url',
              page: () => const Message()),
          ],
        )),
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
    context.read<ReviewStorage>().getReviews();
    context.read<SuccStorage>().getArticles();
    context.read<ReviewStorage>().getMyReviews();
    context.read<FavoriteStorage>().getMyFavorite();
  }

  // 여기까지 함수 등
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (i) {
            setState(() {
              tab = i;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: '홈'),
            BottomNavigationBarItem(
                icon: Icon(Icons.travel_explore), label: '방'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmarks_outlined), label: '북마크'),
            BottomNavigationBarItem(
                icon: Icon(Icons.sms_outlined), label: '메세지'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: '마이페이지'),
          ],
        ),
        body: const [
          home.Page(),
          succ.Page(),
          bookmark.Page(),
          message.ChannelList(),
          profile.Page(),
        ][tab]);
  }
}
