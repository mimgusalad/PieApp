import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:get/get.dart';
import './style.dart' as style;
import 'Storage/image_storage.dart';
import 'Storage/review_storage.dart';
import 'Storage/succ_storage.dart';
import 'Storage/favorite_storage.dart';
import 'Storage/user_storage.dart';
import 'Pages/home.dart' as home;
import 'Pages/favorite.dart' as bookmark;
import 'Pages/mypage.dart' as profile;
import 'Pages/succ.dart' as succ;
import 'Pages/message_list.dart' as message;
import 'Components/message.dart';
import 'Components/review_detail.dart' as reviewDetail;
import 'Components/succ_detail.dart' as succDetail;
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'Storage/url.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: NATIVE_APP_KEY,
    javaScriptAppKey: JAVASCRIPT_APP_KEY,
  );

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => ReviewStorage()),
          ChangeNotifierProvider(create: (c) => SuccStorage()),
          ChangeNotifierProvider(create: (c) => ImageStorage()),
          ChangeNotifierProvider(create: (c) => FavoriteStorage()),
          ChangeNotifierProvider(create: (c) => UserStorage()),
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
            GetPage(
              name: '/profile',
              page: () => profile.Page(),
            )
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
    context.read<FavoriteStorage>().getMyFavorite();
    SendbirdChat.init(appId: APP_ID);
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
        body: [
          home.Page(),
          succ.Page(),
          bookmark.Page(),
          message.ChannelList(),
          profile.Page(),
        ][tab]);
  }
}
