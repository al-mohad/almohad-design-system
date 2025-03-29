import 'package:almohad_design_system/src/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:iconsax/iconsax.dart';

class CopyToClipboardWidget extends StatelessWidget {
  final String text;
  final String? successMessage;
  final String? prefixText;

  const CopyToClipboardWidget({
    super.key,
    required this.text,
    this.prefixText,
    this.successMessage = "Copied to clipboard!",
  });

  void _copyToClipboard(BuildContext context) async {
    Clipboard.setData(ClipboardData(text: text));
    await HapticFeedback.selectionClick();

    if (!context.mounted) return; // Check if context is still mounted
    CustomToasts.show(message: successMessage!, type: ToastType.info);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _copyToClipboard(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixText != null) Text(prefixText!),
            Text(text),
            Gutter.small(),
            const Icon(Iconsax.copy, size: 18),
          ],
        ),
      ),
    );
  }
}

class CopyToClipboardComponent extends StatelessWidget {
  final String text;
  final IconData icon;
  final String label;

  const CopyToClipboardComponent({
    super.key,
    required this.text,
    required this.icon,
    required this.label,
  });

  void _copyToClipboard(BuildContext context) async {
    Clipboard.setData(ClipboardData(text: text));
    await HapticFeedback.selectionClick();

    if (!context.mounted) return; // Check if context is still mounted
    CustomToasts.show(message: "Copied to clipboard!", type: ToastType.info);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$label: $text", style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 5),
        IconButton(
          icon: Icon(icon, size: 20),
          onPressed: () => _copyToClipboard(context),
        ),
      ],
    );
  }
}
