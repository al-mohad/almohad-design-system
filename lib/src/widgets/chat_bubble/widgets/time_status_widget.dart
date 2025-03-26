import 'package:flutter/material.dart';

import '../../../../almohad_design_system.dart';

class TimeStatusWidget extends StatelessWidget {
  final ChatMessage message;
  final TextStyle? textStyle;
  const TimeStatusWidget({super.key, required this.message, this.textStyle});

  @override
  Widget build(BuildContext context) {
    ChatStatus status = message.status;
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              CustomDateHelper.formatTime(
                datetime: message.time,
                context: context,
              ),
              style: textStyle ?? Theme.of(context).textTheme.bodySmall,
            ),
          ),
          if (status == ChatStatus.waiting)
            Padding(
              padding: const EdgeInsets.only(left: 2.5, top: 5.0),
              child: Icon(
                Icons.access_time,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          if (status == ChatStatus.delivered || status == ChatStatus.read)
            Padding(
              padding: const EdgeInsets.only(left: 2.5, top: 5.0),
              child: Icon(
                status == ChatStatus.delivered ? Icons.check : Icons.done_all,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }
}
