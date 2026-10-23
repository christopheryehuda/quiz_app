import 'package:flutter/material.dart';
import '../core/utils/responsive.dart';

class QuestionCard extends StatelessWidget {
  final int number;
  final int total;
  final String text;

  const QuestionCard({
    super.key,
    required this.number,
    required this.total,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.sp(20)),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.sp(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: context.sp(16),
            offset: Offset(0, context.sp(6)),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pertanyaan $number dari $total',
            style: TextStyle(
              fontSize: context.sp(12),
              fontWeight: FontWeight.w500,
              color: scheme.primary,
            ),
          ),
          SizedBox(height: context.sp(10)),
          Text(
            text,
            style: TextStyle(
              fontSize: context.sp(18),
              fontWeight: FontWeight.w700,
              height: 1.4,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}