import 'package:ai_kimi/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // 设置状态栏样式
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AiKimi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, // 设置全局 Scaffold 背景色
      ),
      home: const HomePage(),
    );
  }
}
