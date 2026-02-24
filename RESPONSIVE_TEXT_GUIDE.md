# Responsive Text and Overflow Prevention

## Overview

Both NavSwap and NavSwap Business apps now automatically adapt to users' mobile phone font size preferences and prevent UI overflow errors. This ensures excellent accessibility and a consistent user experience across different device settings.

## Features

### 1. **Automatic Font Size Adaptation**
- Respects user's system font size preferences
- Constrains text scaling between 0.85x and 1.5x to prevent extreme sizes
- Smoothly adapts to accessibility settings

### 2. **Overflow Prevention**
- Automatically prevents text overflow errors
- Provides multiple text widget options for different use cases
- Responsive to different screen sizes

### 3. **Accessibility Support**
- Supports system bold text settings
- Optimized for users with visual impairments
- Maintains readability at all scale factors

## Implementation Details

### Application Level Configuration

Both apps use `MediaQuery` wrapper in `MaterialApp.router` builder:

```dart
MaterialApp.router(
  title: 'App Name',
  theme: AppTheme.theme,
  routerConfig: router,
  builder: (context, child) {
    final mediaQueryData = MediaQuery.of(context);
    final constrainedTextScaleFactor = mediaQueryData.textScaleFactor.clamp(
      ResponsiveUtils.minTextScaleFactor,  // 0.85
      ResponsiveUtils.maxTextScaleFactor,  // 1.5
    );

    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaleFactor: constrainedTextScaleFactor,
        boldText: mediaQueryData.boldText,
      ),
      child: child ?? const SizedBox.shrink(),
    );
  },
)
```

## Responsive Text Widgets

### 1. **ResponsiveText** (Recommended for most cases)

Automatically adapts to user's font size preferences with optional constraints.

```dart
import 'package:your_app/core/widgets/responsive_text.dart';

ResponsiveText(
  'Hello, World!',
  style: Theme.of(context).textTheme.headlineMedium,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  minFontSize: 12.0,  // Optional: Set minimum font size
  maxFontSize: 24.0,  // Optional: Set maximum font size
)
```

**Use cases:**
- Body text
- Titles and headings
- Button labels
- List items

### 2. **AdaptiveText** (For tight spaces)

Automatically adjusts font size to fit available width without overflow.

```dart
AdaptiveText(
  'This text will automatically shrink to fit',
  style: Theme.of(context).textTheme.titleMedium,
  maxLines: 1,
  minFontSize: 10.0,  // Won't go below this size
)
```

**Use cases:**
- Card titles with limited space
- Badges and chips
- Navigation items
- Profile names in constrained areas

### 3. **FittedText** (For scaling content)

Uses FittedBox to scale text to fit available space.

```dart
FittedText(
  'Scaled Text',
  style: Theme.of(context).textTheme.displayLarge,
  fit: BoxFit.scaleDown,  // Only scales down, never up
)
```

**Use cases:**
- Price displays
- Large numbers or stats
- Hero text that must fit in a specific area

### 4. **SafeContainer** (Experimental)

Prevents overflow in complex layouts.

```dart
SafeContainer(
  padding: EdgeInsets.all(16),
  child: Column(
    children: [
      // Your widgets here
    ],
  ),
)
```

## Utility Functions

### ResponsiveUtils

Located in `core/utils/responsive_utils.dart`

#### Get Constrained Text Scale Factor

```dart
final textScale = ResponsiveUtils.getConstrainedTextScaleFactor(context);
// Returns value between 0.85 and 1.5
```

#### Get Responsive Font Size

```dart
final fontSize = ResponsiveUtils.getResponsiveFontSize(
  context: context,
  baseFontSize: 16.0,
  maxFontSize: 20.0,  // Optional
);
```

#### Check Screen Size

```dart
final screenSize = ResponsiveUtils.getScreenSize(context);

// Use screen size for responsive layouts
switch (screenSize) {
  case ScreenSize.small:
    // Adjust layout for small screens
    break;
  case ScreenSize.large:
    // Adjust layout for large screens
    break;
}
```

## Migration Guide

### Updating Existing Code

**Before:**
```dart
Text(
  'My Text',
  style: TextStyle(fontSize: 16),
)
```

**After (Option 1 - Quick Fix):**
```dart
ResponsiveText(
  'My Text',
  style: TextStyle(fontSize: 16),
)
```

**After (Option 2 - Use Theme):**
```dart
ResponsiveText(
  'My Text',
  style: Theme.of(context).textTheme.bodyLarge,
)
```

### For Text in Constrained Spaces

**Before:**
```dart
Container(
  width: 100,
  child: Text(
    'This might overflow',
    overflow: TextOverflow.ellipsis,
  ),
)
```

**After:**
```dart
Container(
  width: 100,
  child: AdaptiveText(
    'This will auto-resize',
    maxLines: 1,
  ),
)
```

## Best Practices

### 1. **Use Theme Text Styles**
Always prefer theme text styles over hardcoded values:
```dart
// Good ✓
ResponsiveText(
  'Title',
  style: Theme.of(context).textTheme.headlineMedium,
)

// Avoid ✗
ResponsiveText(
  'Title',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
)
```

### 2. **Set Max Lines for Long Text**
```dart
ResponsiveText(
  longDescription,
  maxLines: 3,
  overflow: TextOverflow.ellipsis,
)
```

### 3. **Use Appropriate Widget for Use Case**
- **ResponsiveText**: Default choice for most text
- **AdaptiveText**: When text must fit in specific width
- **FittedText**: For scaling entire text as a unit

### 4. **Test with Different Font Sizes**
Test your UI with different system font sizes:
- Go to Settings → Display → Font Size
- Test with Small, Normal, Large, and Extra Large

### 5. **Use Flexible Layouts**
Combine responsive text with flexible layouts:
```dart
Row(
  children: [
    Flexible(
      child: ResponsiveText(
        'This text can wrap and resize',
        maxLines: 2,
      ),
    ),
    Icon(Icons.arrow_forward),
  ],
)
```

## Testing

### Manual Testing Steps

1. **Test Font Scaling:**
   - Go to device Settings → Display → Font Size
   - Change to "Large" or "Largest"
   - Navigate through the app to verify no overflow

2. **Test on Different Screen Sizes:**
   - Small phones (iPhone SE, smaller Android devices)
   - Regular phones
   - Large phones (iPhone Pro Max, etc.)

3. **Test Accessibility:**
   - Enable Bold Text in Settings
   - Enable Increase Contrast
   - Verify readability

### Automated Testing

```dart
testWidgets('ResponsiveText adapts to text scale factor', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: MediaQuery(
          data: MediaQueryData(textScaleFactor: 1.5),
          child: ResponsiveText('Test Text'),
        ),
      ),
    ),
  );
  
  // Add assertions
});
```

## Common Issues and Solutions

### Issue: Text still overflows
**Solution:** Use `AdaptiveText` instead of `ResponsiveText` for constrained spaces.

### Issue: Font too small
**Solution:** Set `minFontSize` parameter:
```dart
ResponsiveText(
  'Text',
  minFontSize: 12.0,
)
```

### Issue: Font too large
**Solution:** Set `maxFontSize` parameter:
```dart
ResponsiveText(
  'Text',
  maxFontSize: 20.0,
)
```

### Issue: Layout breaks with large text
**Solution:** Use `Flexible`, `Expanded`, or `LayoutBuilder` to create flexible layouts.

## Configuration

### Adjusting Scale Limits

To change the min/max scale factors, edit `responsive_utils.dart`:

```dart
class ResponsiveUtils {
  static const double maxTextScaleFactor = 1.5;  // Change this
  static const double minTextScaleFactor = 0.85; // Change this
  // ...
}
```

### Screen Size Breakpoints

Customize screen size breakpoints in `responsive_utils.dart`:

```dart
static ScreenSize getScreenSize(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  
  if (width < 360) {
    return ScreenSize.small;
  } else if (width < 400) {
    return ScreenSize.medium;
  }
  // Add more breakpoints as needed
}
```

## Resources

- [Flutter Accessibility Guide](https://docs.flutter.dev/development/accessibility-and-localization/accessibility)
- [Material Design Typography](https://m3.material.io/styles/typography/overview)
- [Responsive Design in Flutter](https://docs.flutter.dev/development/ui/layout/adaptive-responsive)

## Support

For issues or questions about responsive text implementation:
1. Check this documentation first
2. Review the example implementations
3. Contact the development team

---

**Last Updated:** February 24, 2026
**Version:** 1.0.0
