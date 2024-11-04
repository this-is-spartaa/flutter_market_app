import 'package:flutter_market_app/data/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final userRepository = UserRepository();
  test(
    'UserRepository : login test',
    () async {
      // await userRepository.login();
      final case1 =
          await userRepository.login(username: 'tester', password: '1112');
      // 값이 맞는지 검증
      // 첫번째 파라미터 : 실제값
      // 두번째 파라미터 : 기대값
      // expect(failedResult, false); // test failed
      expect(case1, false);

      final case2 =
          await userRepository.login(username: 'tester', password: '1111');
      expect(case2, true);
    },
  );

  test(
    'UserRepository : username ck test',
    () async {
      final case1 = await userRepository.usernameCk('tester');

      expect(case1, false);

      final case2 = await userRepository.usernameCk('tester222');
      expect(case2, true);
    },
  );

  test(
    'UserRepository : nickname ck test',
    () async {
      final case1 = await userRepository.nicknameCk('테스트');

      expect(case1, false);

      final case2 = await userRepository.nicknameCk('tttttt');
      expect(case2, true);
    },
  );

  test(
    'UserRepository : userInfo ck test',
    () async {
      // 로그인 하지 않으면 회원정보 못가져옴
      final case1 = await userRepository.myInfo();
      expect(case1 == null, true);

      // 로그인해야 헤더에 jwt를 담을 수 있고 회원정보를 가지고 올 수 있음!
      final loginResult =
          await userRepository.login(username: 'tester', password: '1111');
      expect(loginResult, true);

      final case2 = await userRepository.myInfo();
      expect(case2?.username, 'tester');
    },
  );

  // 회원가입은 한번 하면 그 이후에 아이디 바꿔서 가입해야되니 테스트 X
}
