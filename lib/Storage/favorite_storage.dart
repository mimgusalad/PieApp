import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:pie/DTO/review.dart';
import 'url.dart';

class FavoriteStorage extends ChangeNotifier {
  static const userId = 7; // 현재 로그인한 사용자 유저 아이디
  checkIfFavorite(articleNo) async {
    var res = await http.get(Uri.parse('$BASEURL/reviews/favorite?userId=$userId&articleNo=$articleNo'));
    notifyListeners();
    return jsonDecode(res.body); // returns true if favorite, false if not
  }

  void setFavorite(articleNo) async {
    await http.post(Uri.parse('$BASEURL/favorite'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId, // 현재 로그인한 사용자 유저 아이디
          'articleNo': articleNo,
        }));
    notifyListeners();
  }

  List<Review> myFav = [];
  getMyFavorite() async {
    var res = await http.get(Uri.parse('$BASEURL/favorite?userId=$userId'));
    List json = jsonDecode(utf8.decode(res.bodyBytes));
    myFav = json.map<Review>((e) => Review.fromJson(e)).toList();
    notifyListeners();
  }
}
