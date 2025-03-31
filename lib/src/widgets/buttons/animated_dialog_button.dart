import 'package:flutter/material.dart';

class AnimatedInfoButton extends StatefulWidget {
  final String primaryTitle;
  final String secondaryTitle;
  final String title;
  final String description;
  final Widget icon;
  final Color backgroundColor;
  final Color? textColor;
  final Color primaryButtonColor;
  final Color secondaryButtonColor;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final double borderRadius;
  final Duration animationDuration;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final Curve animationCurve;

  const AnimatedInfoButton({
    super.key,
    this.primaryTitle = "Continue",
    this.secondaryTitle = "Cancel",
    this.title = "Title",
    this.description = "Description goes here...",
    this.icon = const Icon(Icons.info, size: 40),
    this.backgroundColor = Colors.white,
    this.textColor,
    this.primaryButtonColor = Colors.white,
    this.secondaryButtonColor = Colors.red,
    this.titleStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    this.descriptionStyle = const TextStyle(
      fontSize: 14,
      color: Colors.white70,
    ),
    this.borderRadius = 15.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
  });

  @override
  AnimatedDialogButtonState createState() => AnimatedDialogButtonState();
}

class AnimatedDialogButtonState extends State<AnimatedInfoButton> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          width: _isExpanded ? 320 : 120,
          constraints: BoxConstraints(minHeight: 50),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: _isExpanded ? _buildExpandedContent() : _buildButton(),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Center(
      child: Text(
        widget.primaryTitle,
        style: TextStyle(
          color: widget.textColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.icon,
            IconButton(
              icon: Icon(Icons.close, color: widget.textColor),
              onPressed: () {
                setState(() {
                  _isExpanded = false;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          widget.title,
          style: widget.titleStyle.copyWith(color: widget.textColor),
        ),
        SizedBox(height: 5),
        Text(
          widget.description,
          textAlign: TextAlign.start,
          style: widget.descriptionStyle,
        ),
        SizedBox(height: 15),
        Align(
          alignment: Alignment.bottomCenter,
          child: Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildActionButton(
                widget.primaryTitle,
                widget.onPrimaryPressed,
                widget.primaryButtonColor,
              ),
              _buildActionButton(
                widget.secondaryTitle,
                widget.onSecondaryPressed,
                widget.secondaryButtonColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String title,
    VoidCallback? onPressed,
    Color buttonColor,
  ) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isExpanded = false;
        });
        if (onPressed != null) onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        title,
        style: TextStyle(color: widget.textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
