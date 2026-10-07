import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A circular progress ring starting at 12 o'clock.
class RingPainter extends CustomPainter {
  RingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
    this.trackStrokeWidth,
    this.inset = 0,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;
  final double? trackStrokeWidth;

  /// Distance from the canvas edge to the ring's centerline.
  final double inset;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - inset;
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = trackStrokeWidth ?? strokeWidth
        ..color = trackColor,
    );
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress.clamp(0.0, 1.0),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(RingPainter old) =>
      old.progress != progress || old.color != color || old.trackColor != trackColor;
}

/// Smooth sparkline with a soft fill, drawn in a 100x30 virtual viewBox.
class SparklinePainter extends CustomPainter {
  SparklinePainter({required this.color});

  final Color color;

  Path _line(Size s) {
    double x(double v) => v / 100 * s.width;
    double y(double v) => v / 30 * s.height;
    // Mirrors SVG path: M0,24 Q15,26 25,18 T50,14 T75,6 T100,10
    return Path()
      ..moveTo(x(0), y(24))
      ..quadraticBezierTo(x(15), y(26), x(25), y(18))
      ..quadraticBezierTo(x(35), y(10), x(50), y(14))
      ..quadraticBezierTo(x(65), y(18), x(75), y(6))
      ..quadraticBezierTo(x(85), y(-6), x(100), y(10));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final line = _line(size);
    final fill = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fill, Paint()..color = color.withValues(alpha: 0.1));
    canvas.drawPath(
      line,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(SparklinePainter old) => old.color != color;
}
