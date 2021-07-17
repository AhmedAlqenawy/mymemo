import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mymemo/constants/const.dart';
class CustomIconButton extends StatelessWidget {
  CustomIconButton({@required this.icon});

  IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 2.h,),
      decoration: BoxDecoration(
          color: kPrimaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.6),
                blurRadius: 1,
                spreadRadius: 1
            )
          ]
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
