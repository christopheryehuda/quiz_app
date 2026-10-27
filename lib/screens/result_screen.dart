import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_assets.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/responsive_center.dart';
import '../widgets/score_circle.dart';
import '../widgets/stat_card.dart';
import '../widgets/theme_toggle_button.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  ({String title, String message}) _feedback(int percentage) {
    if (percentage >= 90) {
      return (title: 'Luar biasa!', message: 'Pengetahuanmu sangat mantap.');
    }
    if (percentage >= 70) {
      return (title: 'Bagus sekali!', message: 'Sedikit lagi menuju sempurna.');
    }
    if (percentage >= 50) {
      return (
      title: 'Lumayan!',
      message: 'Terus belajar, kamu pasti bisa lebih baik.',
      );
    }
    return (
    title: 'Jangan menyerah!',
    message: 'Coba lagi dan pelajari materinya.',
    );
  }

  void _playAgain(BuildContext context) {
    context.read<QuizProvider>().restartQuiz();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // read (bukan watch): data hasil sudah final dan tidak berubah selama
    // halaman ini tampil, jadi tidak ikut rebuild saat "Main Lagi" mereset state.
    final quiz = context.read<QuizProvider>();
    final scheme = Theme.of(context).colorScheme;
    final feedback = _feedback(quiz.percentage);
    final wrong = quiz.totalQuestions - quiz.score;
    final gap = context.sp(16);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.resultTitle),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= Breakpoints.wide;
            final padding = context.sp(20);
            final ringSize =
            (math.min(constraints.maxWidth, constraints.maxHeight) *
                (wide ? 0.55 : 0.5))
                .clamp(140.0, 280.0)
                .toDouble();

            final summary = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssets.trophy,
                  width: ringSize * 0.5,
                  height: ringSize * 0.5,
                ),
                SizedBox(height: gap),
                ScoreCircle(
                  score: quiz.score,
                  total: quiz.totalQuestions,
                  size: ringSize,
                ),
              ],
            );

            final details = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  quiz.userName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.sp(26),
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                  ),
                ),
                SizedBox(height: context.sp(4)),
                Text(
                  feedback.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.sp(18),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: context.sp(6)),
                Text(
                  feedback.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.sp(14),
                    color: scheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: gap * 1.5),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        iconAsset: AppAssets.iconCorrect,
                        label: 'Benar',
                        value: quiz.score,
                        color: AppColors.correct,
                      ),
                    ),
                    SizedBox(width: gap),
                    Expanded(
                      child: StatCard(
                        iconAsset: AppAssets.iconWrong,
                        label: 'Salah',
                        value: wrong,
                        color: AppColors.wrong,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: gap * 1.5),
                CustomButton(
                  label: AppStrings.playAgain,
                  icon: Icons.replay_rounded,
                  onPressed: () => _playAgain(context),
                ),
                SizedBox(height: gap * 0.75),
                CustomButton(
                  label: AppStrings.backToHome,
                  icon: Icons.home_rounded,
                  outlined: true,
                  onPressed: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                ),
              ],
            );

            return SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: math.max(0, constraints.maxHeight - padding * 2),
                ),
                child: ResponsiveCenter(
                  alignment: Alignment.center,
                  maxWidth: wide
                      ? Breakpoints.maxWideWidth
                      : Breakpoints.maxContentWidth,
                  child: wide
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: summary),
                      SizedBox(width: gap * 2),
                      Expanded(child: details),
                    ],
                  )
                      : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      summary,
                      SizedBox(height: gap * 1.5),
                      details,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}