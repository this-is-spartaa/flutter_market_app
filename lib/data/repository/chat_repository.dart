import 'dart:async';

import 'package:flutter_market_app/data/model/chat_room.dart';
import 'package:flutter_market_app/data/repository/base_remote_repository.dart';

class ChatRepository extends BaseRemoteRepository {
  ChatRepository();

  Future<List<ChatRoom>?> list() async {
    final response = await client.get('$host/api/chat/room/list');
    print(response.data);
    if (response.statusCode == 200) {
      return List.of(response.data['content'])
          .map((e) => ChatRoom.fromJson(e))
          .toList();
    }
    return null;
  }

  Future<ChatRoom?> detail(int roomId) async {
    final response = await client.get('$host/api/chat/room/$roomId');
    if (response.statusCode == 200) {
      return ChatRoom.fromJson(response.data['content']);
    }
    return null;
  }

  Future<ChatRoom?> create(int productId) async {
    final response = await client.post('$host/api/chat/room/make/$productId');
    if (response.statusCode == 201) {
      return ChatRoom.fromJson(response.data['content']);
    }
    return null;
  }
}
