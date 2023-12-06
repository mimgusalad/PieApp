
import 'package:dio/dio.dart';

class FormDTO {
  List<MultipartFile> imgList;
  int? userId; // 리뷰 작성 user Id
  String? houseType; // 원룸, 투룸 등 정보
  String? payment; // 전세 혹은 월세
  String? utility; // 관리비
  String? livingYear; //거주년도
  double? rating; // 별점 평가 점수
  int? deposit; //보증금
  int? fee; //월세
  String? address;
  String? addressDetail; // 주소 자세히
  String? contentTitle; // 리뷰 글 제목
  String? contentText; // 리뷰 글 내용
  double? latitude; // 위도
  double? longitude; // 경도

  FormDTO({
    this.houseType,
    this.payment,
    this.utility,
    this.livingYear,
    this.rating,
    this.deposit,
    this.fee,
    this.address,
    this.addressDetail,
    this.contentTitle,
    this.contentText,
    required this.imgList,
    this.userId,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'imgList': imgList,
      'userId': userId,
      'houseType': houseType,
      'payment': payment,
      'utility': utility,
      'livingYear': livingYear,
      'rating': rating,
      'deposit': deposit,
      'fee': fee,
      'address': address,
      'addressDetail': addressDetail,
      'contentTitle': contentTitle,
      'contentText': contentText,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Setter method for imgList
  void setImgList(List<MultipartFile> newList) {
    imgList = newList;
  }

// Add setter methods for other fields as needed
  void setHouseType(String? newHouseType) {
    houseType = newHouseType;
  }
  void setPayment(String? newPayment) {
    payment = newPayment;
  }
  void setUtility(String? newUtility) {
    utility = newUtility;
  }
  void setLivingYear(String? newLivingYear) {
    livingYear = newLivingYear;
  }
  void setRating(double? newRating) {
    rating = newRating;
  }
  void setDeposit(int? newDeposit) {
    deposit = newDeposit;
  }
  void setFee(int? newFee) {
    fee = newFee;
  }
  void setAddress(String? newAddress) {
    address = newAddress;
  }
  void setAddressDetail(String? newAddressDetail) {
    addressDetail = newAddressDetail;
  }
  void setContentTitle(String? newContentTitle) {
    contentTitle = newContentTitle;
  }
  void setContentText(String? newContentText) {
    contentText = newContentText;
  }
  void setUserId(int? newUserId) {
    if(newUserId != null) {
      userId = newUserId!;
    }else{
      userId = 16;
    }
  }
  void setLatitude(double? newLatitude) {
    latitude = newLatitude;
  }
  void setLongitude(double? newLongitude) {
    longitude = newLongitude;
  }
}