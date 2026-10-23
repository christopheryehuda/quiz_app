import 'package:flutter/material.dart';
import '../core/utils/responsive.dart';

class QuizProgressBar extends StatelessWidget {
  final int current;
  final int total;

  const QuizProgressBar({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final value = total == 0 ? 0.0 : current / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progres',
              style: TextStyle(
                fontSize: context.sp(12),
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            Text(
              '$current/$total',
              style: TextStyle(
                fontSize: context.sp(12),
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: context.sp(8)),
        ClipRRect(
          borderRadius: BorderRadius.circular(context.sp(10)),
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: value),
            duration: const Duration(milliseconds: 400),
            builder: (context, animated, _) => LinearProgressIndicator(
              value: animated,
              minHeight: context.sp(10),
              backgroundColor: scheme.primary.withValues(alpha: 0.15),
              color: scheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}