import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AudioTimeStatus extends StatelessWidget {
  final DateTime time;
  final bool isSender;
  final Color doneColor;
  final ChatStatus status;
  final TextStyle? textStyle;
  const AudioTimeStatus({
    super.key,
    required this.time,
    required this.isSender,
    required this.doneColor,
    required this.status,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    double defaultFontSize = Theme.of(context).textTheme.bodyMedium!.fontSize!;
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(
            CustomDateHelper.formatTime(datetime: time, context: context),
            style:
                textStyle?.copyWith(fontSize: defaultFontSize - 3) ??
                TextStyle(
                  fontSize: defaultFontSize - 3,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
          ),
        ),
        if (isSender)
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(
              status == ChatStatus.sent
                  ? Icons.done_rounded
                  : status == ChatStatus.delivered || status == ChatStatus.read
                  ? Icons.done_all_rounded
                  : Iconsax.clock,
              size: defaultFontSize + 3.5,
              color:
                  status == ChatStatus.read
                      ? doneColor
                      : Theme.of(
                        context,
                      ).textTheme.bodyMedium!.color?.withValues(alpha: 0.4),
            ),
          ),
      ],
    );
  }
}
