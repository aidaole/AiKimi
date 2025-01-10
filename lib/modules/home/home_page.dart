import 'package:flutter/material.dart';

import '../chat/chat_page.dart';
import 'unloign_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDrawerOpen = false;

  final int _drawerAnimationDuration = 100;
  // 使用 getter 来动态计算抽屉宽度
  double get _drawerWidth => MediaQuery.of(context).size.width - 80;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              setState(() {
                _isDrawerOpen = true;
              });
            } else if (details.primaryVelocity! < 0) {
              setState(() {
                _isDrawerOpen = false;
              });
            }
          },
          child: Stack(
            children: [
              // 主内容区域
              Positioned.fill(
                // 让主内容填充整个屏幕
                child: AnimatedContainer(
                  duration: Duration(milliseconds: _drawerAnimationDuration),
                  transform: Matrix4.translationValues(
                      _isDrawerOpen ? _drawerWidth : 0, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_isDrawerOpen ? 40 : 0),
                  ),
                  clipBehavior: Clip.antiAlias, // 确保内容不会超出圆角
                  child: Stack(
                    children: [
                      ChatPage(
                        onMenuPressed: () {
                          setState(() {
                            _isDrawerOpen = !_isDrawerOpen;
                          });
                        },
                      ),
                      // 蒙层
                      if (_isDrawerOpen)
                        Container(
                          color: Colors.black.withOpacity(0.3),
                        ),
                    ],
                  ),
                ),
              ),
              // 左侧抽屉
              AnimatedPositioned(
                duration: Duration(milliseconds: _drawerAnimationDuration),
                left: _isDrawerOpen ? 0 : -_drawerWidth,
                top: 0,
                bottom: 0,
                width: _drawerWidth,
                child: _buildDrawerContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildDrawerContent() {
    return const UnloignDrawer();
  }
}
