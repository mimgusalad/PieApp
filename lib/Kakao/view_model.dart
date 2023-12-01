import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:pie/Kakao/social_login.dart';

import 'kakao_login.dart';

class MainViewModel{
  late final SocialLogin _socialLogin;
  bool isLogin = false;
  User? user;

  MainViewModel(this._socialLogin);

  Future login() async{
    isLogin = (await KakaoLogin().login())!;
    if(isLogin){
      user = await UserApi.instance.me(); // 현재 접속한 유저 정보 가져옴
    }
  }
}