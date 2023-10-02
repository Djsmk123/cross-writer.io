import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blogtools/core/utils/extentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showDialogCustom(
    BuildContext context, String title, String message, DialogType type,
    {Function()? onTap}) {
  bool isWeb=context.isWeb();
  AwesomeDialog(
    context: context,
    width: isWeb?0.5.sw:0.8.sw,
    dialogType: type,
    animType: AnimType.rightSlide,
    title: title,
    desc: message,
    showCloseIcon: false,
    //btnCancelOnPress: () {},
    btnOkOnPress: onTap,
  ).show();
}
