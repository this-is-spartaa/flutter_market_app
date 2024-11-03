import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/chat_detail/widgets/chat_detail_receive_item.dart';
import 'package:flutter_market_app/ui/pages/chat_detail/widgets/chat_detail_send_item.dart';

class ChatDetailListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final children = [
      ChatListReceiveItem(
        imgUrl: 'https://picsum.photos/200/300',
        showProfile: true,
        content: '안녕하세요',
        dateTime: DateTime.now(),
      ),
      ChatListReceiveItem(
        imgUrl: 'https://picsum.photos/200/300',
        showProfile: false,
        content: '네고 가능한가요?',
        dateTime: DateTime.now(),
      ),
      ChatListSendItem(
        content: '아니요',
        dateTime: DateTime.now(),
      ),
      ChatListSendItem(
        content: '안된다고 했잖아요',
        dateTime: DateTime.now(),
      ),
    ];
    return Expanded(
      child: ListView.separated(
        itemCount: children.length,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        separatorBuilder: (context, index) => SizedBox(height: 4),
        itemBuilder: (context, index) {
          return children[index];
        },
      ),
    );
  }
}
