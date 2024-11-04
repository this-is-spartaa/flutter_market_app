// final globalViewModel

import 'dart:async';

import 'package:flutter_market_app/data/model/chat_room.dart';
import 'package:flutter_market_app/data/repository/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatGlobalViewModel =
    NotifierProvider<ChatGlobalViewModel, ChatGlobalState>(
        () => ChatGlobalViewModel());

class ChatGlobalState {
  final List<ChatRoom> chatRooms;
  final ChatRoom? currentChat;
  ChatGlobalState({
    required this.chatRooms,
    required this.currentChat,
  });

  ChatGlobalState copyWith({
    List<ChatRoom>? chatRooms,
    ChatRoom? currentChat,
  }) {
    return ChatGlobalState(
      chatRooms: chatRooms ?? this.chatRooms,
      currentChat: currentChat ?? this.currentChat,
    );
  }
}

// AutoDispose 안씀! 앱 내에서 계속 살아있게!
class ChatGlobalViewModel extends Notifier<ChatGlobalState> {
  @override
  ChatGlobalState build() {
    fetchList();
    return ChatGlobalState(
      chatRooms: [],
      currentChat: null,
    );
  }

  final chatRepository = ChatRepository();

  Future<void> fetchList() async {
    final result = await chatRepository.list();
    if (result != null) {
      state = state.copyWith(chatRooms: result);
    }
  }

  Future<void> fetchChatDetail(int roomId) async {
    final result = await chatRepository.detail(roomId);
    if (result != null) {
      state = state.copyWith(currentChat: result);
    }
  }

  void clearChatDetail() {
    state = ChatGlobalState(
      chatRooms: state.chatRooms,
      currentChat: null,
    );
  }

  Future<int?> createChat(int productId) async {
    final result = await chatRepository.create(productId);
    return result?.roomId;
  }
}
