part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatMessagesState extends ChatState {
  final List<ChatMessageModel> messages;

  ChatMessagesState({required this.messages});
}

// 定义消息模型
class ChatMessageModel {
  final String message;
  final bool isUserMessage;
  final DateTime timestamp;

  ChatMessageModel({
    required this.message,
    required this.isUserMessage,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
