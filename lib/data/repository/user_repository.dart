import 'package:flutter_market_app/data/repository/base_remote_repository.dart';

class UserRepository extends BaseRemoteRepository {
  const UserRepository();
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    final response = await client.post('$host/login', data: {
      'username': username,
      'password': password,
    });
    return response.statusCode == 200;
  }
}
