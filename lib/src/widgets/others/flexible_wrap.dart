import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


/*
https://github.com/bixat/flexible_wrap
 */

/// A widget that arranges its children in a flexible wrap layout, allowing them
/// to expand according to available space while maintaining the specified layout
/// properties.
class FlexibleWrap extends Wrap {
  /// Creates a FlexibleWrap widget.
  ///
  /// The [isOneRowExpanded] argument determines whether a single row of children
  /// can expand to fill the available space. The other parameters control the
  /// layout and alignment properties of the wrap.
  const FlexibleWrap(
      {super.key,
        super.children,
        super.textDirection,
        super.spacing,
        super.runSpacing,
        this.isOneRowExpanded = false});

  /// Whether a single row of children can expand to fill available space.
  final bool isOneRowExpanded;

  @override
  RenderWrap createRenderObject(BuildContext context) {
    return _RenderFlexibleWrap(
        spacing: spacing,
        textDirection: textDirection ?? Directionality.maybeOf(context),
        runSpacing: runSpacing,
        isOneRowExpanded: isOneRowExpanded);
  }
}

/// A custom RenderBox that allows flexible wrapping of children within a given layout constraint.
class _RenderFlexibleWrap extends RenderWrap {
  /// Constructs a [_RenderFlexibleWrap].
  ///
  /// The [isOneRowExpanded] parameter decides whether to expand a single row to fill the available space.
  _RenderFlexibleWrap(
      {super.spacing,
        super.textDirection,
        super.runSpacing,
        this.isOneRowExpanded = false});

  /// Indicates whether a single row should be expanded to fill the available space.
  final bool isOneRowExpanded;

  @override
  void performLayout() {
    super.performLayout();
    var child = firstChild;
    final isRtl = textDirection == TextDirection.rtl;
    final parentWidth = constraints.maxWidth;
    double extraWidth = 0.0;
    int baseItems = 0;
    double maxHeight = 0;
    double x = isRtl ? parentWidth : 0;
    double y = 0;

    for (var i = 0; i < childCount; i++) {
      if (child!.size.width == parentWidth) return;
      final double childWidth = child.size.width;

      if (parentWidth.isFinite) {
        final items = (parentWidth / (childWidth + spacing)).floor();
        final isOneRow = items >= childCount && isOneRowExpanded;
        baseItems = (isOneRow ? childCount : items);
        double remainder = parentWidth - ((childWidth + spacing) * baseItems);
        extraWidth = remainder / baseItems;
      }

      final newWidth = extraWidth + childWidth;
      child.layout(BoxConstraints.tight(Size(newWidth, child.size.height)),
          parentUsesSize: true);

      // Adjust x position based on text direction
      final childX = isRtl ? (x - newWidth - spacing / 2) : x + spacing / 2;
      (child.parentData as WrapParentData).offset = Offset(childX, y);

      // Update x position based on text direction
      x = isRtl ? (x - newWidth - spacing) : (x + newWidth + spacing);

      // Handle wrapping to next line
      if (isRtl ? (x <= childWidth) : (x >= parentWidth)) {
        x = isRtl ? parentWidth : 0;
        y += child.size.height;
        y += runSpacing;
      }

      maxHeight =
          (child.parentData as WrapParentData).offset.dy + child.size.height;
      child = childAfter(child);
    }
    size = Size(parentWidth, maxHeight);
  }
}