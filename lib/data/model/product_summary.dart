import 'package:flutter_market_app/data/model/address.dart';
import 'package:flutter_market_app/data/model/file_model.dart';

class ProductSummary {
  final int id;
  final String title;
  final FileModel thumbnail;
  final Address address;
  final int price;
  final int likeCnt;
  final DateTime updatedAt;
  final DateTime createdAt;

  ProductSummary({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.address,
    required this.price,
    required this.likeCnt,
    required this.updatedAt,
    required this.createdAt,
  });

  ProductSummary.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          title: json["title"],
          thumbnail: FileModel.fromJson(json["thumbnail"]),
          address: Address.fromJson(json["address"]),
          price: json["price"],
          likeCnt: json["likeCnt"],
          updatedAt: DateTime.parse(json["updatedAt"]),
          createdAt: DateTime.parse(json["createdAt"]),
        );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail.toJson(),
        "address": address.toJson(),
        "price": price,
        "likeCnt": likeCnt,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
