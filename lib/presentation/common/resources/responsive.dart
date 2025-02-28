import 'dart:math' as math;

import 'package:flutter/material.dart';

class Responsive {
  late double _width, _height, _diagonal;
  late bool _isTablet;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
    _isTablet = size.width > size.height;
  }

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTable => _isTablet;

  double widthPercent(double percent) => _width * percent / 100;
  double heightPercent(double percent) => _height * percent / 100;
  double diagonalPercent(double percent) => _diagonal * percent / 100;
}