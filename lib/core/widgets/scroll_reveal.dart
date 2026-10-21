import 'dart:async';
import 'package:flutter/material.dart';

/// Smooth entrance animation that slides up and fades in with optional staggered delay.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;
  final Curve curve;

  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 650),
    this.slideOffset = 28.0,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  bool _hasStarted = false;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
    _slide = Tween<Offset>(
      begin: Offset(0, widget.slideOffset),
      end: Offset.zero,
    ).animate(curved);

    if (widget.delay == Duration.zero) {
      _controller.forward();
      _hasStarted = true;
    } else {
      _delayTimer = Timer(widget.delay, () {
        if (mounted && !_hasStarted) {
          _controller.forward();
          _hasStarted = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: _slide.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
