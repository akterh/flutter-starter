import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_circle_button.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.buttonTitle,
    this.onTap,
    this.isButtonTitle=true,
    this.isBackButton=false,
  });

  final String? title;
  final String? subtitle;
  final String? buttonTitle;
  final bool? isButtonTitle;
  final Function()? onTap;
  final bool isBackButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: isBackButton,
          child: Positioned(
            left: 20,
              top: 26,
              child: CustomCircleButton()),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      
            if (subtitle != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      subtitle!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,

                    ),
                  ),
                  isButtonTitle==true? Padding(
                    padding: EdgeInsets.only(left: 6.r),
                    child: GestureDetector(
                      onTap: onTap,
                      child: Text(
                        buttonTitle??"",

                      ),
                    ),
                  ):SizedBox(),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
