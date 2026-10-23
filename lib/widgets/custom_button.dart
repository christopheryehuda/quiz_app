import 'package:flutter/material.dart';
import '../core/utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed; // null = tombol nonaktif
  final IconData? icon;
  final bool outlined;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = onPressed != null;
    final radius = BorderRadius.circular(context.sp(16));

    final Color contentColor;
    if (!enabled) {
      contentColor = scheme.onSurface.withValues(alpha: 0.38);
    } else if (outlined) {
      contentColor = scheme.primary;
    } else {
      contentColor = scheme.onPrimary;
    }

    return SizedBox(
      width: double.infinity,
      height: context.sp(54),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            gradient: (enabled && !outlined)
                ? LinearGradient(colors: [scheme.primary, scheme.secondary])
                : null,
            color: enabled ? null : scheme.onSurface.withValues(alpha: 0.12),
            border: (enabled && outlined)
                ? Border.all(color: scheme.primary, width: context.sp(2))
                : null,
            borderRadius: radius,
          ),
          child: InkWell(
            borderRadius: radius,
            onTap: onPressed,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.sp(16)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: contentColor, size: context.sp(22)),
                      SizedBox(width: context.sp(8)),
                    ],
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.sp(16),
                          fontWeight: FontWeight.w700,
                          color: contentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}