import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    required this.isUserMessage,
    required this.message,
  });

  final bool isUserMessage;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        mainAxisAlignment: isUserMessage
            ? MainAxisAlignment.end // 用户消息靠右
            : MainAxisAlignment.start, // 系统消息靠左
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7, // 限制消息最大宽度
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUserMessage ? Colors.blue[100] : Colors.grey[200],
                borderRadius: isUserMessage
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(4),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(12),
                      ),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
