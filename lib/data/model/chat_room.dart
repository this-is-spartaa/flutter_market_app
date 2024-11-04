import 'package:flutter_market_app/data/model/chat_message.dart';
import 'package:flutter_market_app/data/model/chat_product.dart';
import 'package:flutter_market_app/data/model/user.dart';

class ChatRoom {
  final int roomId;
  final ChatProduct product;
  final User sender;
  final List<ChatMessage> messages;
  final DateTime createdAt;

  ChatRoom({
    required this.roomId,
    required this.product,
    required this.sender,
    required this.messages,
    required this.createdAt,
  });

  ChatRoom copyWith({
    int? roomId,
    ChatProduct? product,
    User? sender,
    List<ChatMessage>? messages,
    DateTime? createdAt,
  }) =>
      ChatRoom(
        roomId: roomId ?? this.roomId,
        product: product ?? this.product,
        sender: sender ?? this.sender,
        messages: messages ?? this.messages,
        createdAt: createdAt ?? this.createdAt,
      );

  ChatRoom.fromJson(Map<String, dynamic> json)
      : this(
          roomId: json["roomId"],
          product: ChatProduct.fromJson(json["product"]),
          sender: User.fromJson(json["sender"]),
          messages: List<ChatMessage>.from(
              json["messages"].map((x) => ChatMessage.fromJson(x))),
          createdAt: DateTime.parse(json["createdAt"]),
        );

  Map<String, dynamic> toJson() => {
        "roomId": roomId,
        "product": product.toJson(),
        "sender": sender.toJson(),
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
      };
}
