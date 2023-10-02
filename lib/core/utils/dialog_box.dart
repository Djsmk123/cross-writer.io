import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showDialogCustom(context, String title, String message, DialogType type,
    {Function()? onTap}) {
  AwesomeDialog(
    context: context,
    width: 0.2.sw,
    dialogType: type,
    animType: AnimType.rightSlide,
    title: title,
    desc: message,
    showCloseIcon: false,
    //btnCancelOnPress: () {},
    btnOkOnPress: onTap,
  ).show();
}
