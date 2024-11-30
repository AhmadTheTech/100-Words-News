import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension Animate on Widget {
  Widget applyAnimation({required Color color}) =>
      animate(onPlay: (controller) => controller.repeat())
          .shimmer(duration: 1200.ms, color: color)
          .animate()
          .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
          .slide();

  Widget singleAnimation({required Color color}) =>
      animate(onPlay: (controller) => controller.loop(count: 1))
          .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
          .slide();
}