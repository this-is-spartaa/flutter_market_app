import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/product_detail/widgets/product_detail_actions.dart';
import 'package:flutter_market_app/ui/pages/product_detail/widgets/product_detail_body.dart';
import 'package:flutter_market_app/ui/pages/product_detail/widgets/product_detail_bottom_sheet.dart';
import 'package:flutter_market_app/ui/pages/product_detail/widgets/product_detail_picture.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage(this.productId);
  final int productId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [ProductDetailActions(productId)],
      ),
      extendBody: true,
      bottomSheet: ProductDetailBottomSheet(
        // MediaQuery 현재 context 즉 현재 위젯 기준으로 정보를 제공
        // => device bottom padding(safe area) 영역 구하려면 반드시 Scaffold에서 호출!
        bottomPadding: MediaQuery.of(context).padding.bottom,
        productId: productId,
      ),
      body: ListView(
        children: [
          ProductDetailPicture(productId),
          ProductDetailBody(productId),
        ],
      ),
    );
  }
}
