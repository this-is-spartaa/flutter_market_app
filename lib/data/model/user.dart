import 'package:flutter_market_app/data/model/file_model.dart';

class User {
  final int id;
  final String username;
  final String nickname;
  final FileModel profileImage;

  User({
    required this.id,
    required this.username,
    required this.nickname,
    required this.profileImage,
  });

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          username: json["username"],
          nickname: json["nickname"],
          profileImage: FileModel.fromJson(json["profileImage"]),
        );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "nickname": nickname,
        "profileImage": profileImage.toJson(),
      };
}
