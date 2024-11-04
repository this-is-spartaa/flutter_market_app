import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/product_detail/product_detail_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailPicture extends StatelessWidget {
  const ProductDetailPicture(this.productId, {super.key});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(productDetailViewModel(productId));
        // 아직 로딩 안되었을때
        if (state == null) {
          return const SizedBox();
        }
        return SizedBox(
          height: 500,
          // 리스트뷰와 동일
          // 페이지 넘길 때 사용
          child: PageView.builder(
            itemCount: state.imageFiles.length,
            itemBuilder: (context, index) {
              return Image.network(
                state.imageFiles[index].url,
                fit: BoxFit.cover,
              );
            },
          ),
        );
      },
    );
  }
}
