import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StepHeader extends StatelessWidget {
  final String stepText;
  final String title;

  const StepHeader({
    super.key,
    required this.stepText,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Container(
          height: 4,
          width: 150,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
