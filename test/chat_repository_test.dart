import 'package:flutter_market_app/data/repository/chat_repository.dart';
import 'package:flutter_market_app/data/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final userRepository = UserRepository();
  final chatRepository = ChatRepository();

  test(
    'ChatRepository : list test',
    () async {
      await userRepository.login(username: 'tester', password: '1111');
      final chatList = await chatRepository.list();
      expect(chatList != null, true);
    },
  );

  test(
    'ChatRepository : detail test',
    () async {
      await userRepository.login(username: 'tester', password: '1111');
      final chatList = await chatRepository.list();
      final chatDetail = await chatRepository.detail(chatList!.first.roomId);
      expect(chatDetail != null, true);
    },
  );
  

  // 한 상품당 하나의 채팅방 개설만 가능해서 create는 테스트 제약이 있어서 테스팅 X
}
