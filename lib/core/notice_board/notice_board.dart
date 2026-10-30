import 'package:camerasync/core/constants/app_colors.dart';
import 'package:camerasync/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final title = arguments['title'];
    final message = arguments['message'];

    return Container(
      color: Colors.black,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? "",
            style: kHeading1.copyWith(color: AppColors.kWhiteColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            message ?? "",
            style: kHeading2.copyWith(color: AppColors.kWhiteColor),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
