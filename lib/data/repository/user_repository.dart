import 'package:flutter_market_app/data/model/user.dart';
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

  Future<bool> usernameCk(String username) async {
    final response = await client.get(
      '$host/api/user/usernameCk',
      queryParameters: {
        'username': username,
      },
    );
    return response.statusCode == 200;
  }

  Future<bool> nicknameCk(String nickname) async {
    final response = await client.get(
      '$host/api/user/nicknameCk',
      queryParameters: {
        'nickname': nickname,
      },
    );
    return response.statusCode == 200;
  }

  Future<bool> join({
    required String username,
    required String nickname,
    required String password,
    required String addressFullName,
    required int profileImageId,
  }) async {
    final response = await client.post(
      '$host/api/user/join',
      data: {
        'username': username,
        'nickname': nickname,
        'password': password,
        'addressFullName': addressFullName,
        'profileImageId': profileImageId,
      },
    );

    return response.statusCode == 201;
  }

  Future<User?> myInfo() async {
    final response = await client.get('$host/api/user/myInfo');
    if (response.statusCode == 200) {
      return User.fromJson(response.data['content']);
    }
    return null;
  }
}
