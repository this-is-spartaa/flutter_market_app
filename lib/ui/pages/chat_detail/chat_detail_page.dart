import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/chat_global_view_model.dart';
import 'package:flutter_market_app/ui/pages/chat_detail/widgets/chat_detail_bottom_sheet.dart';
import 'package:flutter_market_app/ui/pages/chat_detail/widgets/chat_detail_list_view.dart';
import 'package:flutter_market_app/ui/pages/chat_detail/widgets/chat_detail_product_area.dart';
import 'package:flutter_market_app/ui/user_global_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final chatRoom = ref.watch(chatGlobalViewModel).currentChat;
            final user = ref.watch(userGlobalViewModel);
            final nickname = chatRoom?.sender.id == user?.id
                ? chatRoom?.product.user.nickname
                : chatRoom?.sender.nickname;
            return Text(nickname ?? '');
          },
        ),
        centerTitle: true,
      ),
      bottomSheet: ChatDetailBottomSheet(
        bottomPadding: MediaQuery.of(context).padding.bottom,
      ),
      body: Column(
        children: [
          ChatDetailProductArea(),
          ChatDetailListView(),
        ],
      ),
    );
  }
}
