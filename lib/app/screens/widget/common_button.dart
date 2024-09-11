import 'package:cart_geek/app/constants/colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final Color? buttonColor;
  final double? width;
  final double? height;

  const CommonButton(
      {super.key,
      required this.child,
      this.onTap,
      this.buttonColor = AppColors.headingColor,
      this.width = 90,
      this.height = 26});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(30)),
            child: child));
  }
}
