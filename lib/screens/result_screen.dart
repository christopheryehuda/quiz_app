import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/responsive_center.dart';

// SEMENTARA: akan diganti total di Tahap 6.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.resultTitle)),
      body: SafeArea(
        child: ResponsiveCenter(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(context.sp(24)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  quiz.userName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: context.sp(20)),
                ),
                SizedBox(height: context.sp(8)),
                Text(
                  'Skor: ${quiz.score}/${quiz.totalQuestions}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.sp(28),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: context.sp(24)),
                CustomButton(
                  label: 'Kembali ke awal',
                  onPressed: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}