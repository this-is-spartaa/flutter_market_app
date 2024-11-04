import 'package:flutter_market_app/data/model/product.dart';
import 'package:flutter_market_app/data/model/product_summary.dart';
import 'package:flutter_market_app/data/repository/base_remote_repository.dart';

class ProductRepository extends BaseRemoteRepository {
  const ProductRepository();

  Future<List<ProductSummary>?> getProductSummaryList(int addressId) async {
    final response = await client.get("$host/api/product", queryParameters: {
      'addressId': addressId,
      'size': 100,
    });

    if (response.statusCode == 200) {
      // 내 상품 조회의 결과에는 페이징 정보가 포함
      // 무한스크롤 기능 구현시 필요하지만 현재 구현안할거니 List<ProductSummary> 타입으로 돌려준다
      return List.of(response.data['content']['content'])
          .map((e) => ProductSummary.fromJson(e))
          .toList();
    }
    return null;
  }

  Future<Product?> fetchDetail(int productId) async {
    final response = await client.get("$host/api/product/$productId");

    if (response.statusCode == 200) {
      return Product.fromJson(response.data['content']);
    }
    return null;
  }
}