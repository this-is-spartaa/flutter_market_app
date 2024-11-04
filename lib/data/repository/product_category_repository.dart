import 'package:flutter_market_app/data/model/product_category.dart';
import 'package:flutter_market_app/data/repository/base_remote_repository.dart';

class ProductCategoryRepository extends BaseRemoteRepository {
  const ProductCategoryRepository();
  // 서버에서 에러 응답 시 => null
  Future<List<ProductCategory>?> getCategoryList() async {
    final response = await client.get("$host/api/product/category");

    if (response.statusCode == 200) {
      return List.of(response.data['content'])
          .map((e) => ProductCategory.fromJson(e))
          .toList();
    }
    return null;
  }
}
