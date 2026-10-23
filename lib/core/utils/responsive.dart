import 'package:flutter/material.dart';

class Breakpoints {
  Breakpoints._();

  /// Lebar minimal layar dianggap tablet.
  static const double tablet = 600;

  /// Lebar maksimal konten agar tidak melebar di tablet/web.
  static const double maxContentWidth = 600;
}

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;
  bool get isTablet => screenSize.shortestSide >= Breakpoints.tablet;

  /// Persen dari lebar layar. Contoh: context.wp(5) = 5% lebar.
  double wp(double percent) => screenWidth * percent / 100;

  /// Persen dari tinggi layar.
  double hp(double percent) => screenHeight * percent / 100;

  /// Skala ukuran (font, padding, ikon) mengikuti sisi terpendek layar,
  /// sehingga tetap proporsional saat rotasi, tablet, maupun web.
  double sp(double size) {
    final scale = (screenSize.shortestSide / 390).clamp(0.85, 1.35).toDouble();
    return size * scale;
  }
}