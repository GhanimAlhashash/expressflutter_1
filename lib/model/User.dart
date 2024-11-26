class User {
  String username;
  String token;
  User({
    required this.username,
    required this.token,
  });

  User.fromjson(dynamic json)
      : username = json["username"],
        token = json["token"];

  Map<String, dynamic> toJson() {
    return {"username": username, "token": token};
  }
}
