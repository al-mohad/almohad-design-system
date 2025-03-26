import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

/// Enum to define dialog types
enum DialogType { info, confirmation, error }

class CustomDialogs {
  CustomDialogs._(); // Prevent instantiation

  /// Generic function to show a modal dialog.
  static Future<void> show({
    required BuildContext context,
    required DialogType type,
    required String message,
    String title = "Information",
    VoidCallback? onProceed,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    TextStyle? buttonTextStyle,
  }) async {
    // Default text styles
    titleStyle ??= const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    messageStyle ??= const TextStyle(fontSize: 16);
    buttonTextStyle ??= const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    // Define styles based on dialog type
    Color backgroundColor;
    List<Widget> actions = [];

    switch (type) {
      case DialogType.info:
        backgroundColor = Colors.white;
        actions.add(
          ElevatedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text('Okay', style: buttonTextStyle),
          ),
        );
        break;

      case DialogType.confirmation:
        backgroundColor = Colors.white;
        actions.addAll([
          TextButton(
            onPressed: onCancel ?? () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text('Cancel', style: buttonTextStyle),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              if (onProceed != null) onProceed();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text('Okay', style: buttonTextStyle),
          ),
        ]);
        break;

      case DialogType.error:
        backgroundColor = Colors.red.shade50;
        barrierDismissible = false;
        actions.add(
          ElevatedButton(
            onPressed: () {
              HapticFeedback.selectionClick();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text('Okay', style: buttonTextStyle),
          ),
        );
        break;
    }

    return WoltModalSheet.show(
      context: context,
      showDragHandle: false,
      barrierDismissible: barrierDismissible,
      pageListBuilder:
          (modalSheetContext) => [
            SliverWoltModalSheetPage(
              backgroundColor: backgroundColor,
              navBarHeight: 26.0,
              pageTitle: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(title, style: titleStyle),
                ),
              ),
              mainContentSliversBuilder:
                  (context) => [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: messageStyle,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: actions,
                        ),
                      ),
                    ),
                  ],
            ),
          ],
    );
  }
}
