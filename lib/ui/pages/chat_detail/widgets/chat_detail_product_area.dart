import 'package:flutter/material.dart';
import 'package:flutter_market_app/core/date_time_utils.dart';
import 'package:flutter_market_app/ui/chat_global_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatDetailProductArea extends StatelessWidget {
  const ChatDetailProductArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final chat = ref.watch(chatGlobalViewModel).currentChat;
        if (chat == null) {
          return SizedBox();
        }
        return Container(
          height: 70,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Colors.grey[300]!,
              ),
            ),
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black, // DefaultTextStyle는 color 필수
              //
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chat.product.title),
                SizedBox(height: 2),
                Text(DateTimeUtils.formatString(chat.createdAt)),
              ],
            ),
          ),
        );
      },
    );
  }
}
