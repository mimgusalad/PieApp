import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pie/DTO/succ.dart';
import 'package:http/http.dart' as http;
import '../DTO/user.dart';
import 'url.dart';

class SuccStorage extends ChangeNotifier{
  List<SuccArticle> articles = [];

  getArticles() async {
    var res = await http.get(Uri.parse('$BASEURL/articles'));
    List json = jsonDecode(utf8.decode(res.bodyBytes));
    articles = json.map<SuccArticle>((e) => SuccArticle.fromJson(e)).toList();
    notifyListeners();
  }

  late int articleId;
  setArticleId(id){
    articleId = id;
    notifyListeners();
  }

  late SuccArticle articleById;
  getArticleById() async{
    var res = await http.get(Uri.parse('$BASEURL/articles/$articleId'));
    final json = jsonDecode(utf8.decode(res.bodyBytes));
    articleById = SuccArticle.fromJson(json);
    notifyListeners();
  }

  late String chatChannelUrl;
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