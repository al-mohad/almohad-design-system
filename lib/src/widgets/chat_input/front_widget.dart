import 'package:almohad_design_system/src/utils/toasts.dart';
import 'package:flutter/material.dart';

class FrontWidget extends StatelessWidget {
  const FrontWidget({
    super.key,
    required this.textEditingController,
    required this.scrollController,
    required this.onChanged,
  });
  final TextEditingController textEditingController;
  final ScrollController scrollController;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            CustomToasts.show(
              context: context,
              type: ToastType.info,
              message: 'show emojies',
            );
          },
          icon: Icon(Icons.emoji_emotions_outlined, color: Colors.transparent),
        ),
        Expanded(
          child: Scrollbar(
            controller: scrollController,
            radius: Radius.circular(5),
            child: Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: TextField(
                controller: textEditingController,
                minLines: 1,
                maxLines: 6,
                onTap: () {},
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(),
                  border: InputBorder.none,
                  hintText: 'Message',
                ),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            CustomToasts.show(
              context: context,
              type: ToastType.info,
              message: 'show picker',
            );
          },
          icon: Icon(Icons.attach_file_outlined, color: Colors.transparent),
        ),
      ],
    );
  }
}
