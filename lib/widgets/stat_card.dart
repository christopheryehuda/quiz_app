import 'package:flutter/material.dart';
import '../core/utils/responsive.dart';

class StatCard extends StatelessWidget {
  final String iconAsset;
  final String label;
  final int value;
  final Color color;

  const StatCard({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.sp(14)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(context.sp(16)),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: context.sp(1.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconAsset, width: context.sp(30), height: context.sp(30)),
          SizedBox(width: context.sp(10)),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$value',
                  style: TextStyle(
                    fontSize: context.sp(22),
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.sp(12),
                    color: scheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}