import 'package:flutter/foundation.dart';
import '../data/dummy_questions.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  QuizProvider({List<Question>? questions})
      : _source = questions ?? dummyQuestions {
    _prepareQuiz();
  }

  final List<Question> _source; // data asli, urutan opsi tetap
  late List<Question> _questions; // salinan dengan opsi diacak per sesi kuis
  late List<int?> _answers; // jawaban terpilih per soal, null = belum dijawab
  String _userName = '';
  int _currentIndex = 0;

  // ---------- Getter ----------
  String get userName => _userName;
  bool get hasName => _userName.isNotEmpty;

  int get totalQuestions => _questions.length;
  int get currentIndex => _currentIndex;
  int get currentNumber => _currentIndex + 1;
  Question get currentQuestion => _questions[_currentIndex];

  int? get selectedAnswer => _answers[_currentIndex];
  bool get hasAnswered => selectedAnswer != null;
  bool get isLastQuestion => _currentIndex == totalQuestions - 1;
  bool get isCompleted => _answers.every((a) => a != null);

  int get score {
    var total = 0;
    for (var i = 0; i < _questions.length; i++) {
      final answer = _answers[i];
      if (answer != null && _questions[i].isCorrect(answer)) total++;
    }
    return total;
  }

  int get percentage =>
      totalQuestions == 0 ? 0 : (score * 100 / totalQuestions).round();

  // ---------- Aksi ----------
  /// Menyiapkan sesi kuis baru: acak opsi tiap soal dan kosongkan jawaban.
  void _prepareQuiz() {
    _questions = [for (final q in _source) q.shuffled()];
    _answers = List<int?>.filled(_questions.length, null);
    _currentIndex = 0;
  }

  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    if (hasAnswered) return; // jawaban dikunci setelah dipilih
    _answers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (!hasAnswered || isLastQuestion) return;
    _currentIndex++;
    notifyListeners();
  }

  /// Ulangi kuis dengan susunan opsi baru, nama pengguna tetap tersimpan.
  void restartQuiz() {
    _prepareQuiz();
    notifyListeners();
  }

  /// Reset total, termasuk nama pengguna.
  void resetAll() {
    _userName = '';
    restartQuiz();
  }
}