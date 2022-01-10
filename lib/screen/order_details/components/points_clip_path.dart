import 'package:flutter/material.dart';

/// Clip widget with points
class PointsClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    double x = 0;
    double y = size.height;
    double increment = size.width / 100;

    while (x < size.width) {
      x += increment;
      y = (y == size.height) ? size.height * .99 : size.height;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }

  // @override
  // bool shouldReclip(CustomClipper old) => old != this;
}
