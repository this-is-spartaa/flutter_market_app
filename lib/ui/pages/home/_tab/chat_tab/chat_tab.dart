import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/chat_tab/widgets/chat_app_bar.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/chat_tab/widgets/chat_list_view.dart';

class ChatTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChatAppBar(),
        ChatListView(),
      ],
    );
  }
}
