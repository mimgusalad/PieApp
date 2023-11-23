import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://10.0.2.2:8080';
var dio = Dio();

class ArticleStorage extends ChangeNotifier{
  List<dynamic> reviews = [];
  getReviews() async {
    var res = await http.get(Uri.parse('$baseUrl/reviews'));
    reviews = jsonDecode(utf8.decode(res.bodyBytes));
    notifyListeners();
  }

  var reviewId;
  setReviewId(id){
    reviewId = id;
    notifyListeners();
  }

  var reviewById;
  getReviewById() async{
    var res = await http.get(Uri.parse('$baseUrl/reviews/$reviewId'));
    reviewById = jsonDecode(utf8.decode(res.bodyBytes));
    debugPrint(reviewById.toString());
    notifyListeners();
  }

}

class ReviewStorage extends ChangeNotifier{

}

class UserStorage extends ChangeNotifier{

}
