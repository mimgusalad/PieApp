import 'package:flutter/material.dart';
import 'package:pie/Kakao/kakao_login.dart';
import 'package:pie/Kakao/view_model.dart';
import 'package:provider/provider.dart';
import '../Components/card.dart' as cards;
import '../Storage/review_storage.dart' as store;
import '../Storage/url.dart';

class Page extends StatefulWidget {
  Page({super.key});

  @override
  State<Page> createState() => _PageState();
}
class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  final viewModel = MainViewModel(KakaoLogin());

  Future<void> _refreshState() async {
    setState(() {}); // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      key: UniqueKey(),
      create: (_) => viewModel,
      child: Consumer<MainViewModel>(
        builder: (context, viewModel, _) {
          return viewModel.isLogin
              ? Scaffold(
            appBar: AppBar(
              title: const Text('마이페이지'),
            ),
            body: RefreshIndicator(
              onRefresh: _refreshState,
              child: ListView(
                children: [
                  ProfileHeader(viewModel: viewModel, refresh: _refreshState),
                  const Divider(
                    height: 10,
                  ),
                  Cards(),
                ],
              ),
            ),
          )
              : LoginPage(viewModel: viewModel);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.viewModel});
  final MainViewModel viewModel;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _handleLogin() async {
    if(mounted){
      await widget.viewModel.login();
      await widget.viewModel.sendbirdLogin();
    }
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

Widget ProfileHeader({required MainViewModel viewModel, required Function refresh}) {
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
        Text(viewModel.user?.kakaoAccount?.profile?.nickname ?? 'null', style: const TextStyle(fontSize: 20)),
        ElevatedButton(
          onPressed: () async {
            await viewModel.logout();
            // Refresh the state after logout
            refresh();
          },
          child: const Text('로그아웃'),
        ),
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
