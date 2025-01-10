part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

// 发送消息事件
class SendMessageEvent extends ChatEvent {
  final String message;

  SendMessageEvent({required this.message});
}

// 接收消息事件（机器人回复）
class ReceiveMessageEvent extends ChatEvent {
  final String message;

  ReceiveMessageEvent({required this.message});
}

// 新聊天事件
class NewChatEvent extends ChatEvent {}
