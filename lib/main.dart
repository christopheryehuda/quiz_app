import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/responsive.dart';
import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';
import 'widgets/custom_button.dart';
import 'widgets/option_tile.dart';
import 'widgets/question_card.dart';
import 'widgets/quiz_progress_bar.dart';
import 'widgets/theme_toggle_button.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => MaterialApp(
          title: 'Quiz App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeProvider.themeMode,
          home: const _WidgetPreview(),
        ),
      ),
    );
  }
}

// SEMENTARA: layar uji coba widget, akan dihapus di Tahap 4.
class _WidgetPreview extends StatelessWidget {
  const _WidgetPreview();

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Tahap 3'),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.wp(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuizProgressBar(
                current: quiz.currentNumber,
                total: quiz.totalQuestions,
              ),
              SizedBox(height: context.hp(2)),
              QuestionCard(
                number: quiz.currentNumber,
                total: quiz.totalQuestions,
                text: question.text,
              ),
              SizedBox(height: context.hp(2)),
              for (var i = 0; i < question.options.length; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: context.hp(1.5)),
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
              SizedBox(height: context.hp(1)),
              CustomButton(
                label: quiz.isLastQuestion ? 'Soal terakhir' : 'Selanjutnya',
                onPressed: quiz.hasAnswered && !quiz.isLastQuestion
                    ? quiz.nextQuestion
                    : null,
              ),
              SizedBox(height: context.hp(1.5)),
              CustomButton(
                label: 'Reset',
                icon: Icons.refresh_rounded,
                outlined: true,
                onPressed: quiz.restartQuiz,
              ),
            ],
          ),
        ),
      ),
    );
  }
}