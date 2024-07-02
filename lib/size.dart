import 'package:flutter/material.dart';

class RelativeSize {
  double _width = 1;
  double _height = 1;

  RelativeSize(BuildContext context) {
    update(context);
  }

  update(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).viewPadding;
    _width = size.width;
    _height = size.height - padding.top - kToolbarHeight;
  }

  double width(double ratio) {
    return _width * ratio;
  }

  double height(double ratio) {
    return _height * ratio;
  }

  double area(double ratio) {
    return _width * _height * ratio;
  }
}

late RelativeSize relativeSize;
