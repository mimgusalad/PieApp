import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:pie/Storage/user_storage.dart';
import '../Components/card.dart' as cards;
import 'package:provider/provider.dart';
import '../Storage/review_storage.dart' as store;
import '../Storage/url.dart';

class Page extends StatefulWidget {
  Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {

  @override
  Widget build(BuildContext context) {
    final isLogin = context.watch<UserStorage>().isLogin;
    return isLogin == true
        ? Scaffold(
            appBar: AppBar(
              title: const Text('마이페이지'),
            ),
            body: RefreshIndicator(
              child: Column(
                children: [ProfileHeader(context), Expanded(child: Cards())],
              ),
              onRefresh: () {
                // get any new data when pulled down
                return context.read<store.ReviewStorage>().getMyReviews();
              },
            ))
        : const LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            // 카카오 로그인
            await UserApi.instance.loginWithKakaoAccount();
            context.read<UserStorage>().setLogin();
            //context.read<UserStorage>().getCurrentUser();
            setState(() {});
          },
          child: const Text('카카오 로그인'),
        ),
      ),
    );
  }
}


Widget ProfileHeader(BuildContext context) {
  return Center(
    child: Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(context.watch<UserStorage>().user?.kakaoAccount?.profile?.profileImageUrl ?? DEFAULT_IMAGE_URL),
          backgroundColor: Colors.green,
          radius: 70,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('사용자 이름', style: TextStyle(fontSize: 20)),
        const SizedBox(
          height: 5,
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(),
        Text('작성한 리뷰', style: TextStyle(fontSize: 20))
      ],
    ),
  );
}

Widget Cards() {
  return ListView.separated(
    itemBuilder: (context, index) {
      return cards.Cards(
          index: index,
          info: context.watch<store.ReviewStorage>().myReviews[index]);
    },
    itemCount: 0,
    //context.watch<store.ReviewStorage>().myReviews.length,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    separatorBuilder: (context, index) {
      return const SizedBox(height: 8);
    },
  );
}
