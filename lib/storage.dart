import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../DTO/user.dart';


const baseUrl = 'http://10.0.2.2:8080';
var dio = Dio();

class ReviewStorage extends ChangeNotifier{
  List<dynamic> reviews = []; // 전체 리뷰글
  getReviews() async {
    var res = await http.get(Uri.parse('$baseUrl/reviews'));
    reviews = jsonDecode(utf8.decode(res.bodyBytes));
    notifyListeners();
  }

  var reviewId; // 리뷰글 id
  setReviewId(id){
    reviewId = id;
    notifyListeners();
  }

  var reviewById; // 리뷰글 id로 검색한 리뷰글
  getReviewById() async{
    var res = await http.get(Uri.parse('$baseUrl/reviews/$reviewId'));
    reviewById = jsonDecode(utf8.decode(res.bodyBytes));
    debugPrint(reviewById.toString());
    notifyListeners();
  }

  var myReviews;// 내가 쓴 리뷰글
  var myId = 7; // 내 아이디
  getMyReviews() async{
    var res = await http.get(Uri.parse('$baseUrl/reviews/my?userId=$myId')); // 대충 아이디 하드코딩 박재현
    myReviews = jsonDecode(utf8.decode(res.bodyBytes));
    notifyListeners();
  }

}

class SuccStorage extends ChangeNotifier{
  List<dynamic> articles = [];
  getArticles() async {
    var res = await http.get(Uri.parse('$baseUrl/articles'));
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
    var res = await http.get(Uri.parse('$baseUrl/articles/$articleId'));
    articleById = jsonDecode(utf8.decode(res.bodyBytes));
    user = User.fromJson(articleById['userInfo']);
    debugPrint(user.toString());
    notifyListeners();
  }

}

class UserStorage extends ChangeNotifier{
}
