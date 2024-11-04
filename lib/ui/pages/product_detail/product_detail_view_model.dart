import 'package:flutter_market_app/data/model/product.dart';
import 'package:flutter_market_app/data/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Product 조회하기 위해서 id 필요 => Family 사용
class ProductDetailViewModel extends AutoDisposeFamilyNotifier<Product?, int> {
  @override
  Product? build(int arg) {
    fetchDetail();
    return null;
  }

  final productRepository = ProductRepository();

  Future<void> fetchDetail() async {
    state = await productRepository.fetchDetail(arg);
  }

  Future<bool> like() async {
    final newLike = await productRepository.like(arg);
    if (newLike != null) {
      state = state?.copyWith(
        myLike: newLike,
      );
      // 업데이트 성공했는지 여부 뷰에 알려줌
      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    return await productRepository.delete(arg);
  }
}

final productDetailViewModel =
    NotifierProvider.autoDispose.family<ProductDetailViewModel, Product?, int>(
  () => ProductDetailViewModel(),
);
