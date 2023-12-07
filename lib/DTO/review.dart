class Review{
  final List<dynamic> img_url;
  final Article article;

  Review({required this.img_url, required this.article});

  factory Review.fromJson(Map<String, dynamic> json){
    return Review(
      img_url: json['img_url'],
      article: Article.fromJson(json['review_article']),
    );
  }

  @override
  String toString() {
    return 'img_url: $img_url, article: $article';
  }

}

class Article {
  final int? articleNo;      //review number
  final int? userId;         // 리뷰 작성 user Id
  final String? houseType;   // 원룸, 투룸 등 정보
  final String? payment;     // 전세 혹은 월세
  final String? utility;     // 관리비
  final String? livingYear;     //거주년도
  final double? rating;      // 별점 평가 점수
  final int? deposit;            //보증금
  final int? fee;                //월세
  final String? address;
  final String? addressDetail;   // 주소 자세히
  final int? likedCnt;       // 공감 횟수
  final String? contentTitle;    // 리뷰 글 제목
  final String? contentText;     // 리뷰 글 내용
  final String? regdate;   // 리뷰 작성 날짜
  final int? certification;  // 입주민 인증 확인
  final int? viewCnt;
  final int? addressId;

  Article({
    this.articleNo,
    this.userId,
    this.houseType,
    this.payment,
    this.utility,
    this.livingYear,
    this.rating,
    this.deposit,
    this.fee,
    this.address,
    this.addressDetail,
    this.likedCnt,
    this.contentTitle,
    this.contentText,
    this.regdate,
    this.certification,
    this.viewCnt,
    this.addressId,
  });

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
      articleNo: json['articleNo'],
      userId: json['userId'],
      houseType: json['houseType'],
      payment: json['payment'],
      utility: json['utility'],
      livingYear: json['livingYear'],
      rating: json['rating'],
      deposit: json['deposit'],
      fee: json['fee'],
      address: json['address'],
      addressDetail: json['addressDetail'],
      likedCnt: json['likedCnt'],
      contentTitle: json['contentTitle'],
      contentText: json['contentText'],
      regdate: json['regdate'],
      certification: json['certification'],
      viewCnt: json['viewCnt'],
      addressId: json['addressId'],
    );
  }

  set articleNo(int? value) {
    articleNo = value;
  }

  set userId(int? value) {
    userId = value;
  }

  set houseType(String? value) {
    houseType = value;
  }

  set payment(String? value) {
    payment = value;
  }

  set utility(String? value) {
    utility = value;
  }

  set livingYear(String? value) {
    livingYear = value;
  }

  set rating(double? value) {
    rating = value;
  }

  set deposit(int? value) {
    deposit = value;
  }

  set fee(int? value) {
    fee = value;
  }

  set address(String? value) {
    address = value;
  }

  set addressDetail(String? value) {
    addressDetail = value;
  }

  set likedCnt(int? value) {
    likedCnt = value;
  }

  set contentTitle(String? value) {
    contentTitle = value;
  }

  set contentText(String? value) {
    contentText = value;
  }

  set regdate(String? value) {
    regdate = value;
  }

  set certification(int? value) {
    certification = value;
  }

  set viewCnt(int? value) {
    viewCnt = value;
  }

  set addressId(int? value) {
    addressId = value;
  }

  @override
  String toString() {
    return 'articleNo: $articleNo, userId: $userId, houseType: $houseType, payment: $payment, utility: $utility, livingYear: $livingYear, rating: $rating, deposit: $deposit, fee: $fee, address: $address, addressDetail: $addressDetail, likedCnt: $likedCnt, contentTitle: $contentTitle, contentText: $contentText, regdate: $regdate, certification: $certification, viewCnt: $viewCnt, addressId: $addressId';
  }

  Map<String, dynamic> toJson() {
    return {
      'articleNo': articleNo,
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
      'likedCnt': likedCnt,
      'contentTitle': contentTitle,
      'contentText': contentText,
      'regdate': regdate,
      'certification': certification,
      'viewCnt': viewCnt,
      'addressId': addressId,
    };
  }

}