import 'package:flutter/cupertino.dart';

class Dimensions {
  Dimensions._();
  static const DefCorner = 6.0;
  static const DefCornerlg = 8.0;
  static const DefCorner2x = 12.0;
  static const DefMargin = 12.0;
  static const DefMarginHalf = 6.0;
  static defVSpacingHalf() => SizedBox(height: DefMarginHalf);
  static defVSpacing() => SizedBox(height: DefMargin);
  static defHSpacingHalf() => SizedBox(width: DefMarginHalf);
  static defHSpacing() => SizedBox(width: DefMargin);
}
