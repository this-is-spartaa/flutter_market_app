import 'package:flutter_market_app/data/repository/address_repository.dart';
import 'package:flutter_market_app/data/repository/product_repository.dart';
import 'package:flutter_market_app/data/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final userRepository = UserRepository();
  final addressRepository = AddressRepository();
  final productRepository = ProductRepository();
  test(
    'ProductRepository : getProductSummaryList test',
    () async {
      await userRepository.login(username: 'tester', password: '1111');
      // 상품을 조회하기 위해서 자신의 동네 ID를 알아야함
      final addresses = await addressRepository.getMyAddresseList();
      final products =
          await productRepository.getProductSummaryList(addresses!.first.id);

      expect(products == null, false);
      for (var product in products!) {
        print(product.toJson());
      }
    },
  );

  test(
    'ProductRepository : fetchDetail test',
    () async {
      await userRepository.login(username: 'tester', password: '1111');
      // productId 1 더미데이터 들어가있기 때문에 productId 1로 테스트
      final product = await productRepository.fetchDetail(1);

      expect(product == null, false);
      print(product!.toJson());
    },
  );
}
