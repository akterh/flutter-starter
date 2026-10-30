import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'app_colors.dart';

class AppLoader {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Container(
            color: Colors.black.withValues(alpha: 0.3),
          ),
          Center(
            child: Container(
              height: 70,
              width: 70,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(8)),
              child: SpinKitSpinningLines(
                color: Colors.white, // change with AppColors.kPrimaryColor
                size: 60.0,
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

// show loader
//AppLoader.show(context);

// hide loader
//AppLoader.dismiss();
