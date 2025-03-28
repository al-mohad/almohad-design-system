import 'dart:math';
import 'dart:ui';

/// Strengthens (darkens or lightens) a given color by a specific factor.
///
/// - `factor > 1.0` makes the color **brighter**.
/// - `factor < 1.0` makes the color **darker**.
/// - `factor == 1.0` returns the original color.
Color getStrengthenColor({required Color color, required double factor}) {
  assert(factor > 0, "Factor must be greater than 0.");

  final r = (color.r * factor).clamp(0, 255).toInt();
  final g = (color.g * factor).clamp(0, 255).toInt();
  final b = (color.b * factor).clamp(0, 255).toInt();

  return Color.fromARGB(color.a.toInt(), r, g, b);
}

/// Generates a random color.
Color getRandomColor({double opacity = 1.0}) {
  final Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256), // Red
    random.nextInt(256), // Green
    random.nextInt(256), // Blue
    opacity, // Opacity (default: 1.0)
  );
}
