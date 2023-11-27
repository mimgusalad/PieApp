import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

const baseUrl = 'http://10.0.2.2:8080';

class FavoriteStorage extends ChangeNotifier {
  static const userId = 7; // 현재 로그인한 사용자 유저 아이디
  checkIfFavorite(articleNo) async {
    var res = await http.get(Uri.parse('$baseUrl/reviews/favorite?userId=$userId&articleNo=$articleNo'));
    debugPrint(res.body);
    notifyListeners();
    return jsonDecode(res.body);
  }

  void setFavorite(articleNo) async {
    var res = await http.post(Uri.parse('$baseUrl/favorite'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId, // 현재 로그인한 사용자 유저 아이디
          'articleNo': articleNo,
        }));
    debugPrint(res.body);
    notifyListeners();
  }

  List myFav = [];
  getMyFavorite() async {
    var res = await http.get(Uri.parse('$baseUrl/favorite?userId=$userId'));
    myFav = jsonDecode(utf8.decode(res.bodyBytes));
    debugPrint(myFav.toString());
    notifyListeners();
  }
}
