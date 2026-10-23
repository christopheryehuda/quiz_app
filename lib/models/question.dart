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
}