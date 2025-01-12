import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:flutter/material.dart';

class _ContextSizeExtension{
  _ContextSizeExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  double get width => _context.appGeneral.mediaQuery.size.width;
  double get height => _context.appGeneral.mediaQuery.size.height;

  double get kZero => 0;
  double get smallValue => height * 0.0075;
  double get normalValue => height * 0.015;
  double get normalMediumValue => height * 0.02;
  double get mediumValue => height * 0.03;
  double get littleLargeValue => height * 0.04;
  double get largeValue => height * 0.1;
  double get floatActionButtonSize => height * 0.08;
  double get middleButtonSize => height * 0.06;
  double get generalComponenteSize => height * 0.07;

  double dynamicWidth(double value) => width * value;
  double dynamicHeigth(double value) => height * value;
}

extension ContextSizeExtension on BuildContext{
  _ContextSizeExtension get sized => _ContextSizeExtension(this);
}