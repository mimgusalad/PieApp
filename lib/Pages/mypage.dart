import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:pie/Kakao/kakao_login.dart';
import 'package:pie/Kakao/view_model.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import '../Components/card.dart' as cards;
import '../Storage/review_storage.dart' as store;
import '../Storage/url.dart';
import '../Storage/user_storage.dart';

class Page extends StatefulWidget {
  Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  final viewModel = MainViewModel(KakaoLogin());


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MainViewModel(KakaoLogin()),
        child: Consumer<MainViewModel>(
        builder: (context, viewModel, _) {
      return viewModel.isLogin
        ? Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
      ),
      body: RefreshIndicator(onRefresh: () { // 새로고침
        return context.read<store.ReviewStorage>().getMyReviews(viewModel.userId!);
      },
        child: ListView(
          children: [
            ProfileHeader(viewModel: viewModel),
            const Divider(
              height: 10,
            ),
            Cards(),
          ],
        ),
      ),
    )
        : LoginPage(viewModel: viewModel);
    }));
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.viewModel});
  final MainViewModel viewModel;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _handleLogin() async {
    await widget.viewModel.login();
    await widget.viewModel.sendbirdLogin();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _handleLogin,
        child: const Text('카카오 로그인'),
      ),
    );
  }
}

Widget ProfileHeader({required MainViewModel viewModel}) {
  return Center(
    child: Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(
              viewModel.user?.kakaoAccount?.profile?.profileImageUrl ??
                  DEFAULT_IMAGE_URL),
          backgroundColor: Colors.green,
          radius: 70,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(viewModel.user?.kakaoAccount?.profile?.nickname ?? 'null', style: TextStyle(fontSize: 20)),
        ElevatedButton(onPressed:() async {
          await viewModel.logout();
        }, child: Text('로그아웃')),
        const Divider(
          height: 10,
        ),
        const Text('작성한 리뷰', style: TextStyle(fontSize: 20))
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
