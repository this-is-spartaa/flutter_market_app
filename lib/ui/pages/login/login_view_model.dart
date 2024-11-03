import 'package:flutter_market_app/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModel = Provider.autoDispose((ref) => LoginViewModel());

// Login Page에서는 관리하는 상태가 없지만
// 유지보수할 때 및 테스트할 때 일관된 구조가 좋으므로
// ViewModel 사용. 단 State 없는 일반 클래스!
class LoginViewModel {
  final userRepository = UserRepository();

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    return await userRepository.login(
      username: username,
      password: password,
    );
  }
}
