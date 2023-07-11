import 'package:flutter/material.dart';

class WeatherCard extends CustomPainter {
  Paint p = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  Paint p2 = Paint()
    ..color = Colors.grey
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;
  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width;
    double y = size.height;
    double arcRadius = 35;

    Path path = Path();
    path.moveTo(arcRadius, 0);
    path.lineTo((x / 2) - arcRadius, 0);
    path.quadraticBezierTo(x / 2, 0, x / 2, arcRadius);
    path.lineTo(x / 2, (y / 2) - arcRadius);
    path.quadraticBezierTo(x / 2, y / 2, (x / 2) + arcRadius, y / 2);
    path.lineTo(x - arcRadius, y / 2);
    path.quadraticBezierTo(x, y / 2, x, (y / 2) + arcRadius);
    path.lineTo(x, y - arcRadius);
    path.quadraticBezierTo(x, y, x - arcRadius, y);
    path.lineTo(arcRadius, y);
    path.quadraticBezierTo(0, y, 0, y - arcRadius);
    path.lineTo(0, arcRadius);
    path.quadraticBezierTo(0, 0, arcRadius, 0);
    canvas.drawPath(path, p);
    canvas.drawPath(path, p2);
    // (const Offset(0,0 ), Offset(size.width/2, 0), p);
    // canvas.drawArc(Rect.fromPoints(, ), startAngle, sweepAngle, useCenter, paint)
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
