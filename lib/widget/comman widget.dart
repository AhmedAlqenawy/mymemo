import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:mymemo/widget/toastt.dart';

Widget doneToast(BuildContext context, String msg) {
  showToastWidget(
      IconToastWidget.success(
        msg: msg,
      ),
      context: context,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.slideToRight,
      reverseAnimation: StyledToastAnimation.sizeFade,
      duration: Duration(seconds: 2),
      animDuration: Duration(seconds: 1),
      curve: Curves.ease,
      reverseCurve: Curves.easeOutQuart);
}

Widget failToast(BuildContext context, String msg) {
  showToastWidget(
      IconToastWidget.fail(
        msg: msg,
      ),
      context: context,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.slideToRight,
      reverseAnimation: StyledToastAnimation.sizeFade,
      duration: Duration(seconds: 2),
      animDuration: Duration(seconds: 1),
      curve: Curves.ease,
      reverseCurve: Curves.easeOutQuart);
}
