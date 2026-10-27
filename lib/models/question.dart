import 'dart:math';

class Question {
  final String text;
  final List<String> options;
  final int correctIndex;

  const Question({
    required this.text,
    required this.options,
    required this.correctIndex,
  });

  bool isCorrect(int selectedIndex) => selectedIndex == correctIndex;

  /// Salinan soal dengan urutan opsi diacak.
  /// correctIndex ikut dihitung ulang supaya tetap menunjuk jawaban yang benar.
  Question shuffled([Random? random]) {
    final order = List<int>.generate(options.length, (i) => i)
      ..shuffle(random);

    return Question(
      text: text,
      options: [for (final i in order) options[i]],
      correctIndex: order.indexOf(correctIndex),
    );
  }
}