// final globalViewModel

import 'package:flutter_market_app/data/model/user.dart';
import 'package:flutter_market_app/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AutoDispose 안씀! 앱 내에서 계속 살아있게!
class GlobalViewModel extends Notifier<User?> {
  @override
  User? build() {
    fetchUserInfo();
    return null;
  }

  final userRepository = UserRepository();

  Future<void> fetchUserInfo() async {
    final user = await userRepository.myInfo();
    state = user;
  }
}

final userGlobalViewModel =
    NotifierProvider<GlobalViewModel, User?>(() => GlobalViewModel());
