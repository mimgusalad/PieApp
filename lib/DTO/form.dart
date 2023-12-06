import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class Form {
  final List<MultipartFile>? img_list;
  final int userId; // 리뷰 작성 user Id
  final String? houseType; // 원룸, 투룸 등 정보
  final String? payment; // 전세 혹은 월세
  final String? utility; // 관리비
  final String? livingYear; //거주년도
  final double? rating; // 별점 평가 점수
  final int? deposit; //보증금
  final int? fee; //월세
  final String? address;
  final String? addressDetail; // 주소 자세히
  final String? contentTitle; // 리뷰 글 제목
  final String? contentText; // 리뷰 글 내용

  Form(
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
      this.img_list,
      this.userId);
}
