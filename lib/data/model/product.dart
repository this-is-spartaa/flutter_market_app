import 'package:flutter_market_app/data/model/address.dart';
import 'package:flutter_market_app/data/model/file_model.dart';
import 'package:flutter_market_app/data/model/product_category.dart';
import 'package:flutter_market_app/data/model/user.dart';

class Product {
  final int id;
  final String title;
  final String content;
  final List<FileModel> imageFiles;
  final User user;
  final Address address;
  final ProductCategory category;
  final int price;
  final int likeCnt;
  final bool myLike;
  final DateTime updatedAt;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.title,
    required this.content,
    required this.imageFiles,
    required this.user,
    required this.address,
    required this.category,
    required this.price,
    required this.likeCnt,
    required this.myLike,
    required this.updatedAt,
    required this.createdAt,
  });

  Product.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          title: json["title"],
          content: json["content"],
          imageFiles: List<FileModel>.from(
              json["imageFiles"].map((e) => FileModel.fromJson(e))),
          user: User.fromJson(json["user"]),
          address: Address.fromJson(json["address"]),
          category: ProductCategory.fromJson(json["category"]),
          price: json["price"],
          likeCnt: json["likeCnt"],
          myLike: json["myLike"],
          updatedAt: DateTime.parse(json["updatedAt"]),
          createdAt: DateTime.parse(json["createdAt"]),
        );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "imageFiles": List<dynamic>.from(imageFiles.map((e) => e.toJson())),
        "user": user.toJson(),
        "address": address.toJson(),
        "category": category.toJson(),
        "price": price,
        "likeCnt": likeCnt,
        "myLike": myLike,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
