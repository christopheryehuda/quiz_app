import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'data/dummy_questions.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Center(
          child: Text(
            '${dummyQuestions.length} pertanyaan dimuat',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}