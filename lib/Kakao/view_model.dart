import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:pie/Kakao/social_login.dart';
import 'package:http/http.dart' as http;
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart' as SB;
import '../DTO/user_info.dart';
import '../Storage/url.dart';

class MainViewModel extends ChangeNotifier {
  late final SocialLogin _socialLogin;
  bool isLogin = false;
  User? user;
  int? userId;

  MainViewModel(this._socialLogin);

  Future sendbirdLogin() async {
    try {
      var res = await SB.SendbirdChat.connect(user!.kakaoAccount!.email!,
        nickname: user!.kakaoAccount!.profile!.nickname,
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
      if (loginResult != null) {
        isLogin = loginResult;
        if (isLogin) {
          user = await UserApi.instance.me();
          var res = await http.get(Uri.parse('$BASEURL/user?email=${user!.kakaoAccount!.email}'));
          userId = jsonDecode(res.body);
          print('userId: $userId');

          notifyListeners();
          return true;
        }
      } else {
        notifyListeners();
        return false;
      }
    } catch (error) {
      print('login error: $error');
      notifyListeners();
      return false;
    }
    notifyListeners();
    return false;
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (error) {
      return false;
    }
  }

}
