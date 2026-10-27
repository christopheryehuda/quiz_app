import 'package:flutter/material.dart';

class ScoreCircle extends StatelessWidget {
  final int score;
  final int total;
  final double size;

  const ScoreCircle({
    super.key,
    required this.score,
    required this.total,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final target = total == 0 ? 0.0 : score / total;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: target),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: value,
                strokeWidth: size * 0.09,
                backgroundColor: scheme.primary.withValues(alpha: 0.15),
                color: scheme.primary,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(size * 0.16),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(value * 100).round()}%',
                          style: TextStyle(
                            fontSize: size * 0.24,
                            fontWeight: FontWeight.w700,
                            color: scheme.primary,
                          ),
                        ),
                        Text(
                          '$score/$total benar',
                          style: TextStyle(
                            fontSize: size * 0.08,
                            color: scheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}