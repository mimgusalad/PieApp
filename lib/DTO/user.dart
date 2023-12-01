class UserInfo{
  String name;
  String email;
  String nickname;
  int userId;

  UserInfo({
    required this.name,
    required this.email,
    required this.nickname,
    required this.userId
  });

  factory UserInfo.fromJson(Map<String, dynamic> json){
    return UserInfo(
      name: json['name'],
      email: json['email'],
      nickname: json['nickname'],
      userId: json['userId'],
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return '$name $email $nickname';
  }
}