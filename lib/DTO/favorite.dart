class Favorite{
  int userId;
  int articleNo;
  String favdate;

  Favorite({
    required this.userId,
    required this.articleNo,
    required this.favdate,
  });

  factory Favorite.fromJson(Map<String, dynamic> json){
    return Favorite(
      userId: json['userId'],
      articleNo: json['articleNo'],
      favdate: json['favdate'],
    );
  }
}