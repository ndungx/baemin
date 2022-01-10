import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    this.press,
    this.textColor,
    this.backgroundColor,
    this.enabled = true,
    this.textStyle,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  final String text;
  final Function? press;
  final Color? textColor, backgroundColor;
  final bool enabled;
  final TextStyle? textStyle;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 40,
      child: Material(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        child: InkWell(
          onTap: enabled ? press as void Function()? : null,
          splashColor: Colors.white.withOpacity(.3),
          radius: 8,
          child: Center(
            child: Text(
              text,
              style: textStyle ??
                  TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
