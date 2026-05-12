import 'dart:math';
import 'package:flutter/material.dart';

class PageFlipWidget extends StatefulWidget {
  final List<Widget> pages;
  final Duration animationDuration;

  const PageFlipWidget({
    super.key,
    required this.pages,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  State<PageFlipWidget> createState() => _PageFlipWidgetState();
}

class _PageFlipWidgetState extends State<PageFlipWidget>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _handleTap,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.pages.length,
        itemBuilder: (context, index) {
          return _buildPage(index);
        },
      ),
    );
  }

  void _handleTap(TapUpDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tapX = details.globalPosition.dx;
    final currentPage = _pageController.page ?? 0;

    if (tapX < screenWidth * 0.3) {
      if (currentPage > 0) {
        _pageController.previousPage(
          duration: widget.animationDuration,
          curve: Curves.easeInOut,
        );
      }
    } else if (tapX > screenWidth * 0.7) {
      if (currentPage < widget.pages.length - 1) {
        _pageController.nextPage(
          duration: widget.animationDuration,
          curve: Curves.easeInOut,
        );
      }
    }
  }

  Widget _buildPage(int index) {
    final double pageOffset = (_pageController.page ?? 0) - index;
    final double absOffset = pageOffset.abs();

    if (absOffset > 1) {
      return const SizedBox.shrink();
    }

    final bool isLeaving = pageOffset > 0;
    final double rotation = pageOffset.clamp(-1.0, 1.0);

    return Transform(
      alignment: isLeaving ? Alignment.centerRight : Alignment.centerLeft,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(rotation * pi / 2),
      child: _buildPageContent(index, absOffset, isLeaving),
    );
  }

  Widget _buildPageContent(int index, double absOffset, bool isLeaving) {
    final double shadowIntensity = (1 - absOffset).clamp(0.0, 1.0);
    final double opacity = (1 - absOffset * 0.3).clamp(0.7, 1.0);

    return Stack(
      children: [
        Opacity(
          opacity: opacity,
          child: widget.pages[index],
        ),
        if (absOffset > 0)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: isLeaving ? Alignment.centerRight : Alignment.centerLeft,
                  end: isLeaving ? Alignment.centerLeft : Alignment.centerRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.3 * shadowIntensity),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        if (absOffset > 0)
          Positioned(
            top: 0,
            bottom: 0,
            left: isLeaving ? null : 0,
            right: isLeaving ? 0 : null,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.5 * shadowIntensity),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
