import 'package:flutter/material.dart';

class AnimatedThumb extends StatefulWidget {
  const AnimatedThumb({super.key});

  @override
  State<AnimatedThumb> createState() => _AnimatedThumbState();
}

class _AnimatedThumbState extends State<AnimatedThumb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _rotation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: (_rotation.value - 0.5) * 0.25,
          child: Transform.scale(
            scale: 0.5 + _scale.value * 0.7,
            child: Icon(
              Icons.thumb_up,
              size: 90,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
