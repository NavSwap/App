import 'package:flutter/material.dart';

/// Utility class for handling responsive text and preventing overflow
class ResponsiveUtils {
  /// Maximum allowed text scale factor to prevent extreme scaling
  static const double maxTextScaleFactor = 1.5;

  /// Minimum allowed text scale factor
  static const double minTextScaleFactor = 0.85;

  /// Get constrained text scale factor
  static double getConstrainedTextScaleFactor(BuildContext context) {
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);
    return textScaleFactor.clamp(minTextScaleFactor, maxTextScaleFactor);
  }

  /// Get responsive font size based on screen width and text scale
  static double getResponsiveFontSize({
    required BuildContext context,
    required double baseFontSize,
    double? maxFontSize,
  }) {
    final textScaleFactor = getConstrainedTextScaleFactor(context);
    final scaledSize = baseFontSize * textScaleFactor;

    if (maxFontSize != null) {
      return scaledSize.clamp(baseFontSize * 0.8, maxFontSize);
    }

    return scaledSize;
  }

  /// Check if text will overflow given constraints
  static bool willTextOverflow({
    required String text,
    required TextStyle style,
    required double maxWidth,
    int maxLines = 1,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.didExceedMaxLines;
  }

  /// Get optimal font size that fits within constraints
  static double getOptimalFontSize({
    required String text,
    required double maxWidth,
    required double baseFontSize,
    required FontWeight fontWeight,
    int maxLines = 1,
  }) {
    double fontSize = baseFontSize;
    const minFontSize = 10.0;

    while (fontSize > minFontSize) {
      final style = TextStyle(fontSize: fontSize, fontWeight: fontWeight);
      if (!willTextOverflow(
        text: text,
        style: style,
        maxWidth: maxWidth,
        maxLines: maxLines,
      )) {
        return fontSize;
      }
      fontSize -= 0.5;
    }

    return minFontSize;
  }

  /// Get screen breakpoint
  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 360) {
      return ScreenSize.small;
    } else if (width < 400) {
      return ScreenSize.medium;
    } else if (width < 600) {
      return ScreenSize.large;
    } else {
      return ScreenSize.extraLarge;
    }
  }
}

/// Screen size breakpoints
enum ScreenSize {
  small,
  medium,
  large,
  extraLarge,
}

extension ScreenSizeExtension on ScreenSize {
  double get scaleFactor {
    switch (this) {
      case ScreenSize.small:
        return 0.9;
      case ScreenSize.medium:
        return 0.95;
      case ScreenSize.large:
        return 1.0;
      case ScreenSize.extraLarge:
        return 1.05;
    }
  }
}
