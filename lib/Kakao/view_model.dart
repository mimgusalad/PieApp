import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:pie/Kakao/social_login.dart';
import 'package:http/http.dart' as http;
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart' as SB;
import '../Storage/url.dart';

class MainViewModel extends ChangeNotifier {
  late final SocialLogin _socialLogin;
  bool isLogin = false;
  User? user;
  int? userId=16;
  bool disposed = false;

  @override
  dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  MainViewModel(this._socialLogin);

  Future sendbirdLogin() async {
    try {
      // var res = await SB.SendbirdChat.connect(user!.kakaoAccount!.email!,
      //   nickname: user!.kakaoAccount!.profile!.nickname,
      //   accessToken: API_TOKEN
      // );
      var res = await SB.SendbirdChat.connect("dakjijisalad@gmail.com",
          nickname: "이경민",
          accessToken: API_TOKEN
      );
      print('res: $res');

      print('sendbird login success');
    } catch (e) {
      print('sendbird login fail');
    }
  }

  Future<bool> login() async {
    try {
      bool? loginResult = await _socialLogin.login();
      print('loginResult: $loginResult');

      if (loginResult == true) {
        isLogin = true;
        user = await UserApi.instance.me();
        print('user: ${user!.kakaoAccount!.email}');
        var res = await http.get(Uri.parse('$BASEURL/user?email=${user!.kakaoAccount!.email}'));
        userId = jsonDecode(res.body);
        print('userId: $userId');

        notifyListeners();
        return true;
      } else {
        isLogin = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      print('login error: $error');
      notifyListeners();
      return false;
    }
  }


  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      isLogin = false;
      return true;
    } catch (error) {
      return false;
    }
  }

}
