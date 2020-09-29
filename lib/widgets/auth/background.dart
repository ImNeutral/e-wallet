import 'dart:math';

import 'package:flutter/material.dart';

class AuthBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.blue.shade700;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();

    ovalPath.moveTo(width, height * 0.2);
    // paint a curve from current position to the middle of the screen
    ovalPath.quadraticBezierTo(0, 0, 0, 0);
    // paint a curve from current position to the bottom left of the screen
    ovalPath.quadraticBezierTo(width * 0.6, height * 0.8, width * 0.1, height * 0.5);

    ovalPath.lineTo(0, height);
    ovalPath.close();
    paint.color = Colors.blue.shade600;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}