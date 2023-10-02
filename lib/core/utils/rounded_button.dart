import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget child;
  final Color? backgroundColor;
  final double height;
  final double width;
  const RoundedButton(
      {super.key,
      this.onTap,
      required this.child,
      this.backgroundColor,
      this.height = 50,
      this.width = 200});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: height.h,
          width: width.w,
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(child: child),
        ));
  }
}
