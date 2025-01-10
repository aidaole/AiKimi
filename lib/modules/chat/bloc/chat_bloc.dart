import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../api/deepseek_api.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<ChatMessageModel> _messages = [];

  ChatBloc() : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<ReceiveMessageEvent>(_onReceiveMessage);
    on<NewChatEvent>(_onNewChat);
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) {
    // 添加用户消息
    _messages.add(ChatMessageModel(
      message: event.message,
      isUserMessage: true,
    ));
    emit(ChatMessagesState(messages: List.from(_messages)));

    // 模拟机器人回复
    Future(() async {
      final api = DeepSeekApi();
      final stream = await api.streamChat(event.message);
      String response = '';
      await for (final content in stream) {
        response += content;
      }
      add(ReceiveMessageEvent(message: response));
    });
  }

  void _onReceiveMessage(ReceiveMessageEvent event, Emitter<ChatState> emit) {
    // 添加机器人回复消息
    _messages.add(ChatMessageModel(
      message: event.message,
      isUserMessage: false,
    ));
    emit(ChatMessagesState(messages: List.from(_messages)));
  }

  FutureOr<void> _onNewChat(NewChatEvent event, Emitter<ChatState> emit) {
    _messages.clear();
    emit(ChatMessagesState(messages: List.from(_messages)));
  }
}
