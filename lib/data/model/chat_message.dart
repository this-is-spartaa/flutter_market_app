class ChatMessage {
  final int id;
  final String messageType;
  final String content;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.messageType,
    required this.content,
    required this.createdAt,
  });

  ChatMessage.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          messageType: json["messageType"],
          content: json["content"],
          createdAt: DateTime.parse(json["createdAt"]),
        );

  Map<String, dynamic> toJson() => {
        "id": id,
        "messageType": messageType,
        "content": content,
        "createdAt": createdAt.toIso8601String(),
      };
}
