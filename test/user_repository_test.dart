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
}
