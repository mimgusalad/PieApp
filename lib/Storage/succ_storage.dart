import 'dart:convert';
import 'package:flutter/material.dart';
import '../DTO/user.dart';
import 'package:http/http.dart' as http;

const BASEURL = 'http://10.0.2.2:8080';
const APP_ID = '4E4C060D-17A6-4CC6-84EA-47D1C87A1F43';
const API_TOKEN = '1d5127c511ce2b3d1e1f27bde93727381958dc63';

class SuccStorage extends ChangeNotifier{
  List<dynamic> articles = [];

  getArticles() async {
    var res = await http.get(Uri.parse('$BASEURL/articles'));
    articles = jsonDecode(utf8.decode(res.bodyBytes));
    notifyListeners();
  }

  var articleId;
  setArticleId(id){
    articleId = id;
    notifyListeners();
  }

  var articleById;
  late User user;
  getArticleById() async{
    var res = await http.get(Uri.parse('$BASEURL/articles/$articleId'));
    articleById = jsonDecode(utf8.decode(res.bodyBytes));
    user = User.fromJson(articleById['userInfo']);
    debugPrint(articleById.toString());
    debugPrint(user.toString());
    notifyListeners();
  }

  var chatChannelUrl;
  setChatChannelUrl(userId, userId2) async {
    var res = await http.post(Uri.parse('https://api-$APP_ID.sendbird.com/v3/group_channels'),
        headers: {
          'Content-Type': 'application/json',
          'Api-Token': API_TOKEN
        },
        body: jsonEncode({
          'users': [
            {'user_id' : userId},
            {'user_id' : userId2}
          ],
          'is_distinct': true,
        }));
    chatChannelUrl = jsonDecode(res.body)['channel_url'];
    notifyListeners();
  }

}