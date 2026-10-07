import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

/// Stand-in for tabs that have no design yet.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconBubble(
            icon: icon,
            background: AppColors.primaryFixed,
            foreground: AppColors.primary,
            size: 64,
            iconSize: 32,
          ),
          const SizedBox(height: 16),
          Text(title, style: AppText.headlineSm),
          const SizedBox(height: 4),
          Text('Coming soon', style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }
}
