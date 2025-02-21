import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/function_tip_item.dart';
import 'bloc/chat_bloc.dart';
import 'widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  final VoidCallback onMenuPressed;

  const ChatPage({
    super.key,
    required this.onMenuPressed,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _hasInput = false;
  late final ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _chatBloc = ChatBloc();
    _textController.addListener(() {
      setState(() {
        _hasInput = _textController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _chatBloc.close();
    super.dispose();
  }

  void _handleSend() {
    if (_textController.text.isEmpty) return;
    _chatBloc.add(SendMessageEvent(message: _textController.text));
    _textController.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _chatBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AiKimi'),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: widget.onMenuPressed,
          ),
          actions: [
            const Icon(Icons.volume_mute),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                _chatBloc.add(NewChatEvent());
              },
              child: const Icon(Icons.message),
            ),
            const SizedBox(width: 20)
          ],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(child: _buildChatContent()),
        SizedBox(
          height: 125,
          child: Column(
            children: [
              _buildFunctionTips(),
              const SizedBox(
                height: 5,
              ),
              _buildChatInputWidget(),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChatContent() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatMessagesState) {
          _scrollToBottom();

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              return ChatMessage(
                isUserMessage: message.isUserMessage,
                message: message.message,
              );
            },
          );
        }
        return const Center(child: Text('开始聊天吧！'));
      },
    );
  }

  Container _buildFunctionTips() {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 10),
            FunctionTipItem(text: '拍照解题', icon: Icons.photo_camera),
            SizedBox(width: 10),
            FunctionTipItem(text: '打电话', icon: Icons.call),
            SizedBox(width: 10),
            FunctionTipItem(text: '翻译', icon: Icons.translate),
            SizedBox(width: 10),
            FunctionTipItem(text: '写作', icon: Icons.edit),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Container _buildChatInputWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // 增加容器高度以适应多行输入
      height: 60,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.mic,
              size: 25,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _textController,
                enabled: true,
                autofocus: false,
                keyboardType: TextInputType.multiline, // 修改为多行键盘类型
                maxLines: null, // 允许无限行数
                textInputAction: TextInputAction.newline, // 回车键变为换行
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '有什么命令尽管问我',
                  hintStyle: TextStyle(
                      fontSize: 18, color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ),
            Icon(Icons.add_circle,
                size: 25, color: Colors.black.withOpacity(0.6)),
            const SizedBox(width: 10),
            _buildSendButton(),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildSendButton() {
    return GestureDetector(
      onTap: _hasInput ? _handleSend : null,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.withOpacity(0.1),
        ),
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Icon(
            _hasInput ? Icons.send : Icons.phone,
            size: 24,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
