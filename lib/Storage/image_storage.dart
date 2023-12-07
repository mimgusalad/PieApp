import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../DTO/review.dart';
import 'url.dart';

var dio = Dio();

class ImageStorage extends ChangeNotifier {
  final List<XFile?> pickedImages = [];

  void addImage(List<XFile> images) {
    pickedImages.addAll(images);
    notifyListeners();
  }

  void deleteImage(XFile image) {
    pickedImages.remove(image);
    notifyListeners();
  }

  void clearImage() {
    pickedImages.clear();
    notifyListeners();
  }

  Future<bool> submitFormToServer(Article article) async {
    Dio dio = Dio();
    FormData _formData;
    final List<MultipartFile> img_list =
        pickedImages.map((e) => MultipartFile.fromFileSync(e!.path)).toList();
    print(img_list);
    _formData = FormData.fromMap({
      'img_list': img_list,
      'review_article.houseType': article.houseType,
      'review_article.payment': article.payment,
      'review_article.utility': article.utility,
      'review_article.livingYear': article.livingYear,
      'review_article.rating': article.rating,
      'review_article.deposit': article.deposit,
      'review_article.fee': article.fee,
      'review_article.address': article.address,
      'review_article.addressDetail': article.addressDetail,
      'review_article.contentTitle': article.contentTitle,
      'review_article.contentText': article.contentText,
      'review_article.userId': article.userId,
    });
    print(article.toJson());

    var res = await dio.post(
      '$BASEURL/checkpost',
      data: _formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
    pickedImages.clear();
    //debugPrint('submitImage() called, res: $res');
    notifyListeners();
    return true;
  }
}
