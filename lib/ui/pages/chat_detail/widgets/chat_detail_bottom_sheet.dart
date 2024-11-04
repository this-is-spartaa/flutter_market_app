import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/chat_global_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatDetailBottomSheet extends ConsumerStatefulWidget {
  final double bottomPadding;

  const ChatDetailBottomSheet({
    super.key,
    required this.bottomPadding,
  });

  @override
  ConsumerState<ChatDetailBottomSheet> createState() =>
      _ChatDetailBottomSheetState();
}

class _ChatDetailBottomSheetState extends ConsumerState<ChatDetailBottomSheet> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSend() {
    if (controller.text.trim().isNotEmpty) {
      ref.read(chatGlobalViewModel.notifier).send(controller.text);
      controller.text = '';
    }
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
