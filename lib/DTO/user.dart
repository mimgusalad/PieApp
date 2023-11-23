class User{
  String name;
  String email;
  String nickname;

  User({required this.name, required this.email, required this.nickname});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        name: json['name'],
        email: json['email'],
        nickname: json['nickname']
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return '$name $email $nickname';
  }
}