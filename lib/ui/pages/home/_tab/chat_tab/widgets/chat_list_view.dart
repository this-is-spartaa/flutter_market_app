import 'package:flutter/material.dart';
import 'package:flutter_market_app/core/date_time_utils.dart';
import 'package:flutter_market_app/data/model/chat_room.dart';
import 'package:flutter_market_app/data/model/user.dart';
import 'package:flutter_market_app/ui/chat_global_view_model.dart';
import 'package:flutter_market_app/ui/pages/chat_detail/chat_detail_page.dart';
import 'package:flutter_market_app/ui/user_global_view_model.dart';
import 'package:flutter_market_app/ui/widgets/user_profile_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final chatRoomList = ref.watch(chatGlobalViewModel).chatRooms;

        // display user 확인용
        final user = ref.watch(userGlobalViewModel);
        if (user == null) {
          return SizedBox();
        }
        return Expanded(
          child: ListView.separated(
            itemCount: chatRoomList.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) {
              return item(chatRoomList[index], user, ref);
            },
          ),
        );
      },
    );
  }

  Widget item(ChatRoom chatRoom, User user, WidgetRef ref) {
    // 항상 내가 아닌 상대방 닉네임 보여줘야하니!
    final displayUser = chatRoom.product.user.id == user.id
        ? chatRoom.sender
        : chatRoom.product.user;
    final displayDateTime = chatRoom.messages.isEmpty
        ? chatRoom.createdAt
        : chatRoom.messages.last.createdAt;
    final message =
        chatRoom.messages.isEmpty ? '' : chatRoom.messages.last.content;
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          ref
              .read(chatGlobalViewModel.notifier)
              .fetchChatDetail(chatRoom.roomId);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ChatDetailPage();
            },
          ));
        },
        child: Container(
          height: 80,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              // 이건 마이탭에서도 쓰이니 글로벌 위젯!
              UserProfileImage(
                  dimension: 50, imgSrc: 'https://picsum.photos/200/300'),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${displayUser.nickname}님',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          DateTimeUtils.formatString(displayDateTime),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Text(message),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
