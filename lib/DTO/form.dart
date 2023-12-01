import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'review.dart';

class Form{
  final List<MultipartFile>? img_list;
  final Article review_article;

  Form(this.img_list, this.review_article);

  factory Form.fromJson(Map<String, dynamic> json){
    return Form(
      json['img_list'],
      json['review_article'],
    );
  }

}