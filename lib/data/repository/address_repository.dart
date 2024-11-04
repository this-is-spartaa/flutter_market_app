import 'package:flutter_market_app/data/model/address.dart';
import 'package:flutter_market_app/data/repository/base_remote_repository.dart';

class AddressRepository extends BaseRemoteRepository {
  const AddressRepository();
  // 서버에서 에러 응답 시 => null
  Future<List<Address>?> getMyAddresseList() async {
    final response = await client.get("$host/api/address");

    if (response.statusCode == 200) {
      return List.of(response.data['content'])
          .map((e) => Address.fromJson(e))
          .toList();
    }
    return null;
  }
}
