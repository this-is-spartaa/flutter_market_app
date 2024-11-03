import 'package:flutter/material.dart';

class ChatDetailBottomSheet extends StatefulWidget {
  final double bottomPadding;

  const ChatDetailBottomSheet({
    super.key,
    required this.bottomPadding,
  });

  @override
  State<ChatDetailBottomSheet> createState() => _ChatDetailBottomSheetState();
}

class _ChatDetailBottomSheetState extends State<ChatDetailBottomSheet> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSend() {
    print(controller.text);
    // 컨트롤러 값 초기화
    controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70 + widget.bottomPadding,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (v) => onSend(),
                  ),
                ),
                GestureDetector(
                  onTap: onSend,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.send,
                      color: Colors.orange,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(height: widget.bottomPadding),
        ],
      ),
    );
  }
}
