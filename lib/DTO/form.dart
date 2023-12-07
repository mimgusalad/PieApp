
import 'package:dio/dio.dart';
import 'package:pie/DTO/review.dart';

class FormDTO {
  late List<MultipartFile> imgList;
  late final Article review;

  Map<String, dynamic> toJson() => {
    'imgList' : imgList,
    'review' : review
  };

  set setImgList(List<MultipartFile> value) {
    imgList = value;
  }
}