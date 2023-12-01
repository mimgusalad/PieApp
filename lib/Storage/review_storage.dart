import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'url.dart';
import '../DTO/review.dart';

var dio = Dio();

class ReviewStorage extends ChangeNotifier{
  List<Review> reviews = []; // 전체 리뷰글
  getReviews() async {
    var res = await http.get(Uri.parse('$BASEURL/reviews'));
    List json = jsonDecode(utf8.decode(res.bodyBytes));
    reviews = json.map<Review>((json) => Review.fromJson(json)).toList();
    debugPrint(reviews.toString());
    notifyListeners();
  }

  var reviewId; // 리뷰글 id
  setReviewId(id){
    reviewId = id;
    notifyListeners();
  }

  late Review reviewById; // 리뷰글 id로 검색한 리뷰글
  getReviewById() async{
    var res = await http.get(Uri.parse('$BASEURL/reviews/$reviewId'));
    final json = jsonDecode(utf8.decode(res.bodyBytes));
    reviewById = Review.fromJson(json);
    notifyListeners();
  }

  late List<Review> myReviews;// 내가 쓴 리뷰글
  var myId = 7; // 내 아이디
  getMyReviews() async{
    var res = await http.get(Uri.parse('$BASEURL/reviews/my?userId=$myId')); // 대충 아이디 하드코딩 박재현
    List json = jsonDecode(utf8.decode(res.bodyBytes));
    myReviews = json.map<Review>((json) => Review.fromJson(json)).toList();
    notifyListeners();
  }
}

