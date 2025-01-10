import 'package:flutter/material.dart';

import '../../widgets/function_tip_item.dart';
import '../chat/widgets/chat_message.dart';

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
  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _hasInput = _textController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_textController.text.isEmpty) return;
    print('发送消息: ${_textController.text}');
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AiKimi'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: widget.onMenuPressed,
        ),
        actions: const [
          Icon(Icons.volume_mute),
          SizedBox(
            width: 20,
          ),
          Icon(Icons.message),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: _buildBody(),
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
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      children: [
        // Kimi的消息 - 靠左
        ChatMessage(isUserMessage: false, message: '你好!我是Kimi'),
        ChatMessage(isUserMessage: true, message: '你好Kimi!'),
      ],
    );
  }

  Container _buildFunctionTips() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FunctionTipItem(text: '拍照解题', icon: Icons.photo_camera),
          FunctionTipItem(text: '打电话', icon: Icons.call),
          FunctionTipItem(text: '翻译', icon: Icons.translate),
          FunctionTipItem(text: '写作', icon: Icons.edit),
        ],
      ),
    );
  }

  Container _buildChatInputWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.mic,
              size: 30,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _textController,
                enabled: true,
                autofocus: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '有什么命令尽管问我',
                  hintStyle: TextStyle(
                      fontSize: 18, color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ),
            Icon(Icons.add_circle,
                size: 30, color: Colors.black.withOpacity(0.6)),
            const SizedBox(width: 10),
            GestureDetector(
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
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
