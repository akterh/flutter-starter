import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../utils/custom_snackbar.dart';
import 'custom_wave_progress.dart';

class AppAlertScreen extends StatelessWidget {
  const AppAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomProgressIndicator(
              value: 0.7,
              thickness: 20,
              waveColor: AppColors.kPrimaryColor,
              waveBackgroundColor: AppColors.kPrimaryColor,
              diagonalStrapColor: AppColors.kPrimaryColor,
              diagonalStrapWidth: 5.0,
              diagonalStrapAngle: 45,
              waveStep: 60,
              enableBounceAnimation: false,
              showLabel: false,
              labelDecoration: BoxDecoration(color: Colors.red),
              diagonalStrapSpacing: 10,
              animateWave: false,
              backgroundColor: AppColors.kPrimaryColor,
            ),
            NotificationCard(
              type: NotificationType.success,
              title: 'Successful',
              subtitle: 'Success notification text',
              onDismiss: () {
                /*showIconSnackbarTop( message: 'Success notification dismissed');*/
                CustomSnackBar.show(
                    context: context,
                    content: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.green.shade300, width: 1),
                      ),
                      child: Text("Success notification dismissed"),
                    ),
                    position: SnackBarPosition.top);
              },
            ),
            const SizedBox(height: 16),
            NotificationCard(
              type: NotificationType.warning,
              title: 'Warning',
              subtitle: 'Warning notification text',
              onDismiss: () {
                CustomSnackBar.show(
                  context: context,
                  position: SnackBarPosition.top,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  animation: SnackBarAnimation.scale,
                  customBuilder: NotificationCard(
                    type: NotificationType.error,
                    title: 'Error',
                    subtitle: 'Error notification text',
                    onDismiss: () {
                      CustomSnackBar.close();
                    },
                  ),
                  content: SizedBox(),
                );
              },
            ),
            const SizedBox(height: 16),
            NotificationCard(
              type: NotificationType.error,
              title: 'Error',
              subtitle: 'Error notification text',
              onDismiss: () {},
            ),
          ],
        ),
      ),
    );
  }
}

enum NotificationType { success, warning, error }

class NotificationCard extends StatelessWidget {
  final NotificationType type;
  final String title;
  final String subtitle;
  final VoidCallback onDismiss;

  const NotificationCard({
    super.key,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final (
      Color backgroundColor,
      Color iconBackgroundColor,
      Color borderColor,
      IconData icon
    ) = switch (type) {
      NotificationType.success => (
          Colors.green.shade50,
          Colors.green.shade700,
          Colors.green.shade300,
          Icons.check_circle_outline
        ),
      NotificationType.warning => (
          Colors.orange.shade50,
          Colors.orange.shade700,
          Colors.orange.shade300,
          Icons.warning_amber_outlined
        ),
      NotificationType.error => (
          Colors.red.shade50,
          Colors.red.shade700,
          Colors.red.shade300,
          Icons.error_outline
        ),
    };

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Leading icon with colored background
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Close button
            IconButton(
              icon: Icon(Icons.close, color: Colors.grey.shade600),
              onPressed: onDismiss,
              splashRadius: 20,
              iconSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
