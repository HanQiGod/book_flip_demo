import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  final String title;
  final String content;
  final Color color;
  final int pageNumber;

  const DemoPage({
    super.key,
    required this.title,
    required this.content,
    required this.color,
    required this.pageNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '第 $pageNumber 页',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<DemoPage> getDemoPages() {
  return [
    const DemoPage(
      title: '欢迎阅读',
      content: '这是一个 Flutter 翻书效果演示\n左右滑动体验翻页效果',
      color: Color(0xFF6C5CE7),
      pageNumber: 1,
    ),
    const DemoPage(
      title: '第一章',
      content: '翻书效果可以应用于\n电子书、杂志、画册等场景\n提供真实的阅读体验',
      color: Color(0xFF00B894),
      pageNumber: 2,
    ),
    const DemoPage(
      title: '第二章',
      content: '使用 3D Transform 实现\n透视变换带来逼真的翻页动画\n支持手势滑动控制',
      color: Color(0xFFE17055),
      pageNumber: 3,
    ),
    const DemoPage(
      title: '第三章',
      content: 'Flutter 强大的动画系统\n让自定义过渡效果变得简单\n无需第三方依赖',
      color: Color(0xFF0984E3),
      pageNumber: 4,
    ),
    const DemoPage(
      title: '第四章',
      content: '通过 PageController 控制\n可以监听滚动位置\n实现精确的动画同步',
      color: Color(0xFFFD79A8),
      pageNumber: 5,
    ),
    const DemoPage(
      title: '感谢阅读',
      content: '翻书效果演示结束\n感谢您的体验！',
      color: Color(0xFF636E72),
      pageNumber: 6,
    ),
  ];
}
