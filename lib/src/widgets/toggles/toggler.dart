import 'package:flutter/material.dart';

class TransformingAnimatedToggleSwitch extends StatefulWidget {
  final List<String> primaryValues;
  final List<String> secondaryValues;
  final void Function(int index, String value) onPrimaryToggle;
  final void Function(int index, String value) onSecondaryToggle;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Color backgroundColor;
  final TextStyle textStyle;
  final double width;
  final double height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final bool showShadow;

  const TransformingAnimatedToggleSwitch({
    super.key,
    required this.primaryValues,
    required this.secondaryValues,
    required this.onPrimaryToggle,
    required this.onSecondaryToggle,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.white,
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = Colors.black,
    this.backgroundColor = Colors.grey,
    this.textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    this.width = 250,
    this.height = 60,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.margin = const EdgeInsets.all(0),
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.showShadow = true,
  });

  @override
  TransformingAnimatedToggleSwitchState createState() =>
      TransformingAnimatedToggleSwitchState();
}

class TransformingAnimatedToggleSwitchState
    extends State<TransformingAnimatedToggleSwitch> {
  int primaryIndex = 0;
  int secondaryIndex = 0;
  bool showSecondaryOptions = false;

  void _togglePrimary() {
    setState(() {
      if (primaryIndex == 0) {
        primaryIndex = 1;
        Future.delayed(widget.animationDuration, () {
          setState(() {
            showSecondaryOptions = true;
          });
        });
      } else {
        primaryIndex = 0;
        showSecondaryOptions = false;
      }
      widget.onPrimaryToggle(primaryIndex, widget.primaryValues[primaryIndex]);
    });
  }

  void _toggleSecondary() {
    setState(() {
      secondaryIndex = (secondaryIndex + 1) % widget.secondaryValues.length;
      widget.onSecondaryToggle(
        secondaryIndex,
        widget.secondaryValues[secondaryIndex],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double expandedWidth = widget.width * 2;

    return AnimatedContainer(
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      width: showSecondaryOptions ? expandedWidth : widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: _togglePrimary,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        widget.primaryValues[0],
                        style: widget.textStyle.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: _togglePrimary,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        widget.primaryValues[1],
                        style: widget.textStyle.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimatedAlign(
            alignment:
                primaryIndex == 1
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            child: GestureDetector(
              onTap: _togglePrimary,
              child: Container(
                width:
                    showSecondaryOptions
                        ? expandedWidth * .5
                        : widget.width * .45,
                height: widget.height * .8,
                decoration: BoxDecoration(
                  color: widget.activeColor,
                  borderRadius: widget.borderRadius,
                  boxShadow:
                      widget.showShadow
                          ? [
                            BoxShadow(
                              offset: const Offset(3, 3),
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 5,
                            ),
                            BoxShadow(
                              offset: const Offset(-3, -3),
                              color: Colors.white.withValues(alpha: 0.3),
                              blurRadius: 5,
                            ),
                          ]
                          : [],
                ),
                alignment: Alignment.center,
                child:
                    showSecondaryOptions
                        ? SecondaryToggleSwitch(
                          onToggle: _toggleSecondary,
                          index: secondaryIndex,
                          values: widget.secondaryValues,
                          textStyle: widget.textStyle,
                        )
                        : Text(
                          widget.primaryValues[primaryIndex],
                          style: widget.textStyle.copyWith(color: Colors.white),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondaryToggleSwitch extends StatelessWidget {
  final VoidCallback onToggle;
  final int index;
  final List<String> values;
  final TextStyle textStyle;

  const SecondaryToggleSwitch({
    super.key,
    required this.onToggle,
    required this.index,
    required this.values,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          // color: Colors.blueGrey[700],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Row(
              children:
                  values.map((text) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          text,
                          style: textStyle.copyWith(
                            color:
                                text == values[index]
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            AnimatedAlign(
              alignment:
                  index == 1 ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 300),
              // todo user can pass height and widht, color, duration, and text style
              child: Container(
                width: 90,
                height: 35,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                ),
                alignment: Alignment.center,
                child: Text(
                  values[index],
                  style: textStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
