import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/widgets/user_profile_image.dart';

class ChatListReceiveItem extends StatelessWidget {
  ChatListReceiveItem({
    required this.imgUrl,
    required this.showProfile,
    required this.content,
    required this.dateTime,
  });
  final String imgUrl;
  final bool showProfile;
  final String content;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showProfile
            ? UserProfileImage(
                imgSrc: imgUrl,
                dimension: 50,
              )
            : SizedBox(width: 50),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Text(
                // TODO 고치기! 우선 toIso8601String으로 구현
                dateTime.toIso8601String(),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black45,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
