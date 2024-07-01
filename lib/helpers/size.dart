import 'package:flutter/material.dart';

class RelativeSize {
  double _width;
  double _height;

  RelativeSize(this._width, this._height);

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

RelativeSize relativeSize = RelativeSize(1, 1);
