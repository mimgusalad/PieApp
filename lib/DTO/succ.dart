import 'package:pie/DTO/user_info.dart';

class SuccArticle{
  final succession_article article;
  final List<dynamic> img_url;
  final UserInfo? user;

  SuccArticle({
    required this.article,
    required this.img_url,
    required this.user
  });

  factory SuccArticle.fromJson(Map<String, dynamic> json){
    return SuccArticle(
      article: succession_article.fromJson(json['succession_article']),
      img_url: json['img_url'],
      user: UserInfo.fromJson(json['userInfo']),
    );
  }


}

class succession_article {
  final int articleNo;  // 승계글 id
  final int userId;     //작성자 user id
  final String? payType; // 월세 전세인지 선택
  final String? houseType;   // 원룸, 투룸,, 등 방구조 저장
  final int? periodYear;     // 계약기간 년도 저장
  final int? periodMonth;    // 계약기간 월 저장
  final int? periodDay;      //계약기간 일 저장
  final int? deposit;    // 보증금
  final String? address;     // 도로명 주소 및 구 주소
  final String? addressDetail;   // 상세주소
  final int? fee;    //월세
  final int? payment;        // 관리비
  final double? area;    // 승계 건물 면적
  final String? contentText; //승계글 text
  final String? contentTitle;    // 승계글 제목
  final String? optionQuality;   // 승계방 옵션 물건 저장
  final String? successionQuality;  // 승계 물건 저장
  final int? modCnt;  // 끌올 횟수 저장
  final String? moddate;  // 끌올 날짜 저장
  final String? regDate; // 게시글 작성 날짜 및 수정 날짜 기록
  final int? viewCnt;

  succession_article({
    required this.articleNo,
    required this.userId,
    required this.payType,
    required this.houseType,
    required this.periodYear,
    required this.periodMonth,
    required this.periodDay,
    required this.deposit,
    required this.address,
    required this.addressDetail,
    required this.fee,
    required this.payment,
    required this.area,
    required this.contentText,
    required this.contentTitle,
    required this.optionQuality,
    required this.successionQuality,
    required this.modCnt,
    required this.moddate,
    required this.regDate,
    required this.viewCnt,
  });

  factory succession_article.fromJson(Map<String, dynamic> json){
    return succession_article(
      articleNo: json['articleNo'],
      userId: json['userId'],
      payType: json['payType'],
      houseType: json['houseType'],
      periodYear: json['periodYear'],
      periodMonth: json['periodMonth'],
      periodDay: json['periodDay'],
      deposit: json['deposit'],
      address: json['address'],
      addressDetail: json['addressDetail'],
      fee: json['fee'],
      payment: json['payment'],
      area: json['area'],
      contentText: json['contentText'],
      contentTitle: json['contentTitle'],
      optionQuality: json['optionQuality'],
      successionQuality: json['successionQuality'],
      modCnt: json['modCnt'],
      moddate: json['moddate'],
      regDate: json['regDate'],
      viewCnt: json['viewCnt'],
    );
  }
}