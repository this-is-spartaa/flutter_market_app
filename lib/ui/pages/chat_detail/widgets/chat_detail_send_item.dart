import 'package:flutter/material.dart';

class ChatListSendItem extends StatelessWidget {
  ChatListSendItem({
    required this.content,
    required this.dateTime,
  });
  final String content;
  final DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
                // TODO 고치기
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