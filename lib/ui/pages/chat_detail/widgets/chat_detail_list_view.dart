import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/chat_global_view_model.dart';
import 'package:flutter_market_app/ui/pages/chat_detail/widgets/chat_detail_receive_item.dart';
import 'package:flutter_market_app/ui/pages/chat_detail/widgets/chat_detail_send_item.dart';
import 'package:flutter_market_app/ui/user_global_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatDetailListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final chatRoom = ref.watch(chatGlobalViewModel).currentChat;
        if (chatRoom == null) {
          return SizedBox();
        }

        // 내 메시지인지 아닌지 판별하기 위해서!
        final user = ref.watch(userGlobalViewModel)!;

        return Expanded(
          child: ListView.separated(
            itemCount: chatRoom.messages.length,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            separatorBuilder: (context, index) => SizedBox(height: 4),
            itemBuilder: (context, index) {
              final message = chatRoom.messages[index];
              final msgSender = message.messageType == "SENDER_TO_PRODUCT_OWNER"
                  ? chatRoom.sender
                  : chatRoom.product.user;

              if (msgSender.id == user.id) {
                return ChatListSendItem(
                  content: message.content,
                  dateTime: message.createdAt,
                );
              }
              bool showProfile = true;
              if (index > 0) {
                final previousMessage = chatRoom.messages[index - 1];
                showProfile =
                    previousMessage.messageType != message.messageType;
              }
              return ChatListReceiveItem(
                imgUrl: msgSender.profileImage.url,
                showProfile: showProfile,
                content: message.content,
                dateTime: message.createdAt,
              );
            },
          ),
        );
      },
    );
  }
}
