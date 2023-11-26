import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

const baseUrl = 'http://10.0.2.2:8080';
var dio = Dio();

class ImageStorage extends ChangeNotifier{
  final List<XFile?> pickedImages = [];

  void addImage(List<XFile> images){
    pickedImages.addAll(images);
    notifyListeners();
  }

  void deleteImage(XFile image){
    pickedImages.remove(image);
    notifyListeners();
  }

  void submitImage() async {
    FormData _formData;
    final List<MultipartFile> img_list = pickedImages.map((e) => MultipartFile.fromFileSync(e!.path)).toList();
    dio.options.contentType = 'multipart/form-data';
    _formData = FormData.fromMap({
      'images': img_list,
    });
    var res = await dio.post('$baseUrl/checkpost2', data: _formData);
    pickedImages.clear();
    //debugPrint('submitImage() called, res: $res');
    notifyListeners();
  }
}