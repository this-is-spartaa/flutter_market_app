import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/chat_global_view_model.dart';
import 'package:flutter_market_app/ui/pages/chat_detail/chat_detail_page.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/home_tab/home_tap_view_model.dart';
import 'package:flutter_market_app/ui/pages/product_detail/product_detail_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProductDetailBottomSheet extends StatelessWidget {
  const ProductDetailBottomSheet({
    required this.bottomPadding,
    required this.productId,
  });

  final double bottomPadding;
  final int productId;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final vm = ref.read(productDetailViewModel(productId).notifier);
        final state = ref.watch(productDetailViewModel(productId));

        if (state == null) {
          return const SizedBox();
        }
        return Container(
          height: 50 + bottomPadding,
          color: Colors.white,
          child: Column(
            children: [
              Divider(height: 0),
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final result = await vm.like();
                        // 좋아요하면 홈탭 재로드
                        // 다른 뷰를 업데이트 하는 방법 여러가지
                        // 1. 업데이트 안하고 pull to refresh 구현
                        // 2. ViewModel 안의 객체 업데이트
                        // 3. 서버에서 새로고침
                        // 등등
                        if (result) {
                          ref.read(homeTabViewModel.notifier).fetchProducts();
                        }
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.transparent,
                        child: Icon(state.myLike
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart),
                      ),
                    ),
                    VerticalDivider(
                      width: 20,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Text(
                        NumberFormat('###,###원').format(state.price),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          final chatViewModel =
                              ref.read(chatGlobalViewModel.notifier);
                          final roomId =
                              await chatViewModel.createChat(productId);
                          // ChatTab에서 쓰는 리스트 업데이트
                          await chatViewModel.fetchList();
                          if (roomId != null) {
                            chatViewModel.fetchChatDetail(roomId);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ChatDetailPage();
                              },
                            ));
                          }
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ChatDetailPage();
                            },
                          ));
                        },
                        child: Text(
                          '채팅하기',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              SizedBox(height: bottomPadding),
            ],
          ),
        );
      },
    );
  }
}
