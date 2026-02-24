import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

/// A text widget that automatically adapts to user's font size preferences
/// and prevents overflow by scaling down when necessary
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow overflow;
  final TextAlign? textAlign;
  final bool softWrap;
  final double? minFontSize;
  final double? maxFontSize;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign,
    this.softWrap = true,
    this.minFontSize,
    this.maxFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = style ?? Theme.of(context).textTheme.bodyMedium;
    final baseFontSize = defaultStyle?.fontSize ?? 14.0;

    final responsiveFontSize = ResponsiveUtils.getResponsiveFontSize(
      context: context,
      baseFontSize: baseFontSize,
      maxFontSize: maxFontSize,
    );

    final constrainedFontSize = responsiveFontSize.clamp(
      minFontSize ?? baseFontSize * 0.75,
      maxFontSize ?? baseFontSize * 1.5,
    );

    final responsiveStyle = defaultStyle?.copyWith(
      fontSize: constrainedFontSize,
    );

    return Text(
      text,
      style: responsiveStyle,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
    );
  }
}

/// A fitted text widget that automatically scales to fit available space
class FittedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final BoxFit fit;
  final TextAlign? textAlign;
  final int? maxLines;

  const FittedText(
    this.text, {
    super.key,
    this.style,
    this.fit = BoxFit.scaleDown,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: fit,
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
      ),
    );
  }
}

/// A text widget that automatically adjusts font size to prevent overflow
class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;
  final TextAlign? textAlign;
  final double? minFontSize;

  const AdaptiveText(
    this.text, {
    super.key,
    this.style,
    this.maxLines = 1,
    this.textAlign,
    this.minFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final defaultStyle = style ?? Theme.of(context).textTheme.bodyMedium;
        final baseFontSize = defaultStyle?.fontSize ?? 14.0;

        final optimalFontSize = ResponsiveUtils.getOptimalFontSize(
          text: text,
          maxWidth: constraints.maxWidth,
          baseFontSize: baseFontSize,
          fontWeight: defaultStyle?.fontWeight ?? FontWeight.normal,
          maxLines: maxLines,
        );

        final constrainedFontSize = optimalFontSize.clamp(
          minFontSize ?? baseFontSize * 0.6,
          baseFontSize,
        );

        return Text(
          text,
          style: defaultStyle?.copyWith(fontSize: constrainedFontSize),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
        );
      },
    );
  }
}

/// A safe container that prevents overflow in its children
class SafeContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Decoration? decoration;
  final double? width;
  final double? height;

  const SafeContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      width: width,
      height: height,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: child,
      ),
    );
  }
}
