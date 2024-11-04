import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/home_tab/home_tap_view_model.dart';
import 'package:flutter_market_app/ui/pages/product_detail/product_detail_view_model.dart';
import 'package:flutter_market_app/ui/pages/product_write/product_write_page.dart';
import 'package:flutter_market_app/ui/user_global_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailActions extends StatelessWidget {
  ProductDetailActions(this.productId);
  // Family 뷰모델 사용하기 위해서 위젯에서 넘겨줘야함
  final int productId;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final vm = ref.read(productDetailViewModel(productId).notifier);
        final state = ref.watch(productDetailViewModel(productId));
        // 이미 로그인 되어있기때문에 read 사용
        final user = ref.read(userGlobalViewModel);

        if (state?.user.id != user?.id) {
          return SizedBox();
        }
        return Row(
          children: [
            GestureDetector(
              onTap: () async {
                final result = await vm.delete();
                if (result) {
                  // 업데이트 하고 homeTab도 갱신
                  // 다른 뷰를 업데이트 하는 방법 여러가지
                  // 1. 업데이트 안하고 pull to refresh 구현
                  // 2. ViewModel 안의 객체 업데이트
                  // 3. 서버에서 새로고침
                  // 등등
                  final result = await vm.delete();
                  if (result) {
                    ref.read(homeTabViewModel.notifier).fetchProducts();
                    Navigator.pop(context);
                  }
                  ref.read(homeTabViewModel.notifier).fetchProducts();
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Icon(Icons.delete),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ProductWritePage(state);
                  },
                ));
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Icon(Icons.edit),
              ),
            )
          ],
        );
      },
    );
  }
}
