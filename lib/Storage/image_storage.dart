import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../DTO/form.dart';
import 'url.dart';

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

  void clearImage(){
    pickedImages.clear();
    notifyListeners();
  }

  Future<void> submitFormToServer(FormDTO formDTO) async {
    print('submitFormToServer');
    print(formDTO.toJson());
    Dio dio = new Dio();
    try{
      Response res = await dio.post(
        '$BASEURL/form',
        data: formDTO.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
    }catch(e){
      print(e);
    }
  }
}