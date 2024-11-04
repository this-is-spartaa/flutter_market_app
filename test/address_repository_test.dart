import 'package:flutter_market_app/data/repository/address_repository.dart';
import 'package:flutter_market_app/data/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final userRepository = UserRepository();
  final addressRepository = AddressRepository();
  test(
    'AddressRepository : getMyAddress test',
    () async {
      // 로그인 안할 시 403에러!
      final resultWithNoAuth = await addressRepository.getMyAddresseList();
      expect(resultWithNoAuth == null, true);

      // 로그인 성공 시 Header에 Auth Token 담아주기때문에 진행
      await userRepository.login(username: 'tester', password: '1111');
      final result = await addressRepository.getMyAddresseList();
      expect(result == null, false);
      expect(result!.length, 1);
      expect(result.first.defaultYn, true);
      expect(result.first.displayName, '온천동');
    },
  );
}
