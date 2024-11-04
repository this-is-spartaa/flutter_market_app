import 'dart:async';
import 'dart:convert';

import 'package:flutter_market_app/data/model/chat_room.dart';
import 'package:flutter_market_app/data/repository/base_remote_repository.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

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

  ChatSocket connectSocket() {
    // onConnect 및 chatRoomStream에서 사용하려고 선언
    StompClient? stompClient;
    // Stream을 리턴하기위해 StreamController 만들기
    final chatRoomStream = StreamController<ChatRoom>(
      onListen: () {
        // listen 하면 activate 호출해서 웹소켓 연결
        stompClient?.activate();
      },
      onCancel: () {
        // onCancel 호출 시 연결 끊기!
        stompClient?.deactivate();
      },
    );
    stompClient = StompClient(
      // http 통신으로 웹소켓 업그레이드 할 떈 sockJS!
      config: StompConfig.sockJS(
        url: '$host/ws',
        // header에 jst 싣으면 웹에서 사용불가(웹은 웹소켓에 헤더 지원X => 웹도 지원하려면 쿼리스트링으로!)
        webSocketConnectHeaders: {
          "transports": ["websocket"],
          'content-type': 'application/octet-stream',
          'Authorization': bearerToken,
        },
        onConnect: (StompFrame frame) {
          // 웹소켓 연결 되면 구독하기!
          stompClient?.subscribe(
            destination: '/user/queue/pub',
            // 구독 콜백
            callback: (frame) {
              chatRoomStream.add(ChatRoom.fromJson(jsonDecode(frame.body!)));
            },
          );
        },
        // beforeConnect: () async {},
        // onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );

    return ChatSocket(
      messageStream: chatRoomStream.stream,
      // 함수 만들어서 던져주기!(뷰모델에서는 서버 통신할 때의 데이터 가공을 신경쓸 필요 없게!)
      sendMessage: ({required content, required roomId}) {
        stompClient?.send(
          destination: '/chat-socket/chat.send',
          body: jsonEncode({"content": content, "roomId": roomId}),
        );
      },
    );
  }
}

// ChatRepository에 종속적. 즉 ChatRepository 없으면 안쓰니까 여기 배치

class ChatSocket {
  ChatSocket({
    required this.messageStream,
    required this.sendMessage,
  });
  final Stream<ChatRoom> messageStream;
  final void Function({
    required int roomId,
    required String content,
  }) sendMessage;
}
