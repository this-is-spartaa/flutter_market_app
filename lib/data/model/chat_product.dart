import 'package:flutter_market_app/data/model/address.dart';
import 'package:flutter_market_app/data/model/user.dart';

class ChatProduct {
  final int id;
  final String title;
  final User user;
  final Address address;
  final int price;

  ChatProduct({
    required this.id,
    required this.title,
    required this.user,
    required this.address,
    required this.price,
  });

  ChatProduct.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          title: json["title"],
          user: User.fromJson(json["user"]),
          address: Address.fromJson(json["address"]),
          price: json["price"],
        );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "user": user.toJson(),
        "address": address.toJson(),
        "price": price,
      };
}
