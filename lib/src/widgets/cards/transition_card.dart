import 'package:flutter/material.dart';

const BoxDecoration _expandedDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(16)),
);

class ExpandableWidget extends StatefulWidget {
  final List<Widget> expandedChildren;
  final Widget collapsedContent;
  final BoxDecoration? expandedDecoration;
  final BoxDecoration? collapsedDecoration;
  const ExpandableWidget({
    super.key,
    required this.expandedChildren,
    required this.collapsedContent,
    this.expandedDecoration,
    this.collapsedDecoration,
  });

  @override
  LocationWidgetState createState() => LocationWidgetState();
}

class LocationWidgetState extends State<ExpandableWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 40 : 100,
            width: isExpanded ? size.width * 0.78 : size.width * 0.7,
            height: isExpanded ? size.height * 0.6 : size.height * 0.5,
            // child: ExpandedContentWidget(),
            child: Container(
              decoration: widget.expandedDecoration ?? _expandedDecoration,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.expandedChildren,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 150 : 100,
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              onTap: () {},
              // child: ImageWidget(),
              child: Container(
                /// space from white container
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: size.height * 0.5,
                width: size.width * 0.8,
                decoration:
                    widget.collapsedDecoration ??
                    _expandedDecoration.copyWith(color: Colors.indigo),
                child: widget.collapsedContent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}
