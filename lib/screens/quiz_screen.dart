import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/option_tile.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_progress_bar.dart';
import '../widgets/responsive_center.dart';
import '../widgets/theme_toggle_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  Future<void> _confirmExit(BuildContext context) async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text('Progres jawabanmu akan hilang.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    if (leave == true && context.mounted) Navigator.of(context).pop();
  }

  void _finish(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ResultScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;
    final gap = context.sp(16);

    final progress = QuizProgressBar(
      current: quiz.currentNumber,
      total: quiz.totalQuestions,
    );

    final card = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: QuestionCard(
        key: ValueKey(quiz.currentIndex),
        number: quiz.currentNumber,
        total: quiz.totalQuestions,
        text: question.text,
      ),
    );

    final options = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < question.options.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: context.sp(12)),
            child: OptionTile(
              index: i,
              text: question.options[i],
              state: OptionState.resolve(
                index: i,
                selected: quiz.selectedAnswer,
                correctIndex: question.correctIndex,
              ),
              onTap: () => quiz.selectAnswer(i),
            ),
          ),
      ],
    );

    final nextButton = CustomButton(
      label: quiz.isLastQuestion ? AppStrings.finish : AppStrings.next,
      icon: quiz.isLastQuestion
          ? Icons.flag_rounded
          : Icons.arrow_forward_rounded,
      onPressed: !quiz.hasAnswered
          ? null
          : quiz.isLastQuestion
          ? () => _finish(context)
          : quiz.nextQuestion,
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Halo, ${quiz.userName}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: const [ThemeToggleButton()],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= Breakpoints.wide;

              return SingleChildScrollView(
                padding: EdgeInsets.all(context.sp(20)),
                child: ResponsiveCenter(
                  maxWidth: wide
                      ? Breakpoints.maxWideWidth
                      : Breakpoints.maxContentWidth,
                  child: wide
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      progress,
                      SizedBox(height: gap),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: card),
                          SizedBox(width: gap * 1.5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: [
                                options,
                                SizedBox(height: gap / 2),
                                nextButton,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      progress,
                      SizedBox(height: gap),
                      card,
                      SizedBox(height: gap),
                      options,
                      SizedBox(height: gap / 2),
                      nextButton,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}