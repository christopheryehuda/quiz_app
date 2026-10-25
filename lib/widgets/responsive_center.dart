import 'package:flutter/material.dart';
import '../core/utils/responsive.dart';

class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final Alignment alignment;

  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = Breakpoints.maxContentWidth,
    this.alignment = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}