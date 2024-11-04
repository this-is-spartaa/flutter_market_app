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
    // build 메서드 에서는 await 불가!(return type이 Future이면 안됨)
    fetchList().then(
      (value) {
        // 리스트가 다 불러와지면 소켓 연결!
        connectSocket();
      },
    );
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

  ChatSocket? chatSocket;
  StreamSubscription<ChatRoom>? _subscription;

  // 소켓 연결 하기
  void connectSocket() {
    chatSocket = chatRepository.connectSocket();
    _subscription = chatSocket!.messageStream.listen((newChat) {
      // 실시간으로 메시지가 오면 채팅방 리스트의 메시지 업데이트
      handleChat(newChat);
      // 채팅방 디테일 이 있으면 업데이트!
      handleChatRooms(newChat);
    });
    // 이 뷰모델이 소거(앱이종료될 때) 될 때 구독 종료!
    ref.onDispose(
      () {
        _subscription?.cancel();
      },
    );
  }

  void handleChat(ChatRoom newChat) {
    final currentChat = state.currentChat;
    if (currentChat != null && currentChat.roomId == newChat.roomId) {
      state = state.copyWith(
          currentChat: currentChat.copyWith(
        messages: [...currentChat.messages, newChat.messages.first],
      ));
    }
  }

  void handleChatRooms(ChatRoom newChat) {
    final chatRooms = state.chatRooms;
    final isExist =
        chatRooms.where((e) => e.roomId == newChat.roomId).isNotEmpty;
    if (isExist) {
      final newList = chatRooms
          .map((e) => e.roomId == newChat.roomId ? newChat : e)
          .toList();
      state = state.copyWith(chatRooms: newList);
    } else {
      state = state.copyWith(
        chatRooms: [...chatRooms, newChat],
      );
    }
  }

  void send(String content) async {
    final currentChat = state.currentChat;
    if (currentChat != null) {
      chatSocket?.sendMessage(
        roomId: currentChat.roomId,
        content: content,
      );
    }
  }
}
