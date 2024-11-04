import 'package:flutter_market_app/data/repository/product_category_repository.dart';
import 'package:flutter_market_app/data/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final userRepository = UserRepository();
  final productCategoryRepository = ProductCategoryRepository();
  test(
    'ProductCategoryRepository : getCategoryList test',
    () async {
      await userRepository.login(username: 'tester', password: '1111');
      final results = await productCategoryRepository.getCategoryList();
      expect(results == null, false);
      for (var category in results!) {
        print(category.toJson());
      }
    },
  );
}
