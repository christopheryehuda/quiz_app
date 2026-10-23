import 'package:flutter/material.dart';
import '../core/constants/app_assets.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

enum OptionState {
  idle, // belum dijawab
  correct, // jawaban benar
  wrong, // jawaban yang dipilih tapi salah
  disabled; // opsi lain setelah soal dijawab

  /// Menentukan status tampilan satu opsi.
  static OptionState resolve({
    required int index,
    required int? selected,
    required int correctIndex,
  }) {
    if (selected == null) return OptionState.idle;
    if (index == correctIndex) return OptionState.correct;
    if (index == selected) return OptionState.wrong;
    return OptionState.disabled;
  }
}

class OptionTile extends StatelessWidget {
  final int index;
  final String text;
  final OptionState state;
  final VoidCallback? onTap;

  const OptionTile({
    super.key,
    required this.index,
    required this.text,
    this.state = OptionState.idle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(context.sp(14));

    late final Color background;
    late final Color border;
    late final Color badge;
    late final Color badgeText;
    String? iconAsset;

    switch (state) {
      case OptionState.idle:
        background = scheme.surface;
        border = scheme.onSurface.withValues(alpha: 0.12);
        badge = scheme.primary.withValues(alpha: 0.12);
        badgeText = scheme.primary;
      case OptionState.correct:
        background = AppColors.correct.withValues(alpha: 0.12);
        border = AppColors.correct;
        badge = AppColors.correct;
        badgeText = Colors.white;
        iconAsset = AppAssets.iconCorrect;
      case OptionState.wrong:
        background = AppColors.wrong.withValues(alpha: 0.12);
        border = AppColors.wrong;
        badge = AppColors.wrong;
        badgeText = Colors.white;
        iconAsset = AppAssets.iconWrong;
      case OptionState.disabled:
        background = scheme.surface;
        border = scheme.onSurface.withValues(alpha: 0.06);
        badge = scheme.onSurface.withValues(alpha: 0.06);
        badgeText = scheme.onSurface.withValues(alpha: 0.38);
    }

    final textColor = state == OptionState.disabled
        ? scheme.onSurface.withValues(alpha: 0.5)
        : scheme.onSurface;

    return Material(
      color: background,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: border, width: context.sp(2)),
      ),
      child: InkWell(
        onTap: state == OptionState.idle ? onTap : null,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.sp(14),
            vertical: context.sp(12),
          ),
          child: Row(
            children: [
              Container(
                width: context.sp(34),
                height: context.sp(34),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: badge, shape: BoxShape.circle),
                child: Text(
                  String.fromCharCode(65 + index), // A, B, C, D
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.w700,
                    color: badgeText,
                  ),
                ),
              ),
              SizedBox(width: context.sp(12)),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: context.sp(15),
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              if (iconAsset != null) ...[
                SizedBox(width: context.sp(8)),
                Image.asset(
                  iconAsset,
                  width: context.sp(26),
                  height: context.sp(26),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}