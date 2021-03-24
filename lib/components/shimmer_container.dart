import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;

  const ShimmerContainer(
      {Key key, this.baseColor, this.highlightColor, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade600,
      highlightColor: highlightColor ?? Colors.grey.shade700,
      child: child,
    );
  }
}
