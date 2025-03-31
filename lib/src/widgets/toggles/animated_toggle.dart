import 'package:flutter/material.dart';

class AnimatedToggleSwitch extends StatefulWidget {
  final List<String> values;
  final void Function(int index, String value) onToggle;
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
  final List<IconData>? icons; // Optional icons

  const AnimatedToggleSwitch({
    super.key,
    required this.values,
    required this.onToggle,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.white,
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = Colors.black,
    this.backgroundColor = Colors.grey,
    this.textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    this.width = 200,
    this.height = 60,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.margin = const EdgeInsets.all(0),
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.showShadow = true,
    this.icons,
  });

  @override
  AnimatedToggleSwitchState createState() => AnimatedToggleSwitchState();
}

class AnimatedToggleSwitchState extends State<AnimatedToggleSwitch> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isToggled = !isToggled;
          });
          widget.onToggle(isToggled ? 1 : 0, widget.values[isToggled ? 1 : 0]);
        },
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background container
              Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: widget.borderRadius,
                ),
              ),

              // Centered Labels
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(widget.values.length, (index) {
                    return Expanded(
                      child: Center(
                        child:
                            widget.icons != null
                                ? Icon(
                                  widget.icons![index],
                                  color: Colors.grey.shade600,
                                  size: widget.height * 0.4,
                                )
                                : Text(
                                  widget.values[index],
                                  style: widget.textStyle.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                      ),
                    );
                  }),
                ),
              ),

              // Animated Toggle Button
              AnimatedAlign(
                alignment:
                    isToggled ? Alignment.centerRight : Alignment.centerLeft,
                duration: widget.animationDuration,
                curve: widget.animationCurve,
                child: Padding(
                  padding: EdgeInsets.all(widget.height * 0.1),
                  child: Container(
                    width: widget.width * 0.45,
                    height: widget.height * 0.8,
                    decoration: BoxDecoration(
                      color:
                          isToggled ? widget.activeColor : widget.inactiveColor,
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
                                  color:
                                      isToggled
                                          ? Colors.white.withValues(alpha: 0.3)
                                          : Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 5,
                                ),
                              ]
                              : [],
                    ),
                    alignment: Alignment.center,
                    child:
                        widget.icons != null
                            ? Icon(
                              widget.icons![isToggled ? 1 : 0],
                              color:
                                  isToggled
                                      ? widget.activeTextColor
                                      : widget.inactiveTextColor,
                              size: widget.height * 0.4,
                            )
                            : Text(
                              widget.values[isToggled ? 1 : 0],
                              style: widget.textStyle.copyWith(
                                color:
                                    isToggled
                                        ? widget.activeTextColor
                                        : widget.inactiveTextColor,
                              ),
                            ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
