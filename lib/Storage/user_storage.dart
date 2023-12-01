import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'url.dart';

class UserStorage extends ChangeNotifier {
  late int currentUserId;
  setCurrentUserId(String email) async {
    var res = await http.get(Uri.parse('$BASEURL/user?email=$email'));
    currentUserId = int.parse(res.body);
    notifyListeners();
  }

  bool isLogin = false;

  setLogin() {
    isLogin = true;
    notifyListeners();
  }

  late User? user;

  setUser(User user) async {
    user = await UserApi.instance.me();
    notifyListeners();
  }
}
