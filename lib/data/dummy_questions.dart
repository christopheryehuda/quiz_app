import '../models/question.dart';

const List<Question> dummyQuestions = [
  Question(
    text: 'Bahasa pemrograman apa yang digunakan untuk membuat aplikasi Flutter?',
    options: ['Kotlin', 'Swift', 'Dart', 'JavaScript'],
    correctIndex: 2,
  ),
  Question(
    text: 'Widget yang tampilannya tidak berubah setelah dibuat disebut...',
    options: ['StatefulWidget', 'StatelessWidget', 'InheritedWidget', 'ChangeNotifier'],
    correctIndex: 1,
  ),
  Question(
    text: 'Method apa yang dipanggil untuk memperbarui tampilan pada StatefulWidget?',
    options: ['setState()', 'initState()', 'dispose()', 'createState()'],
    correctIndex: 0,
  ),
  Question(
    text: 'Widget mana yang menyusun anak-anaknya secara vertikal?',
    options: ['Row', 'Stack', 'Expanded', 'Column'],
    correctIndex: 3,
  ),
  Question(
    text: 'File apa yang digunakan untuk mendaftarkan dependency dan aset di Flutter?',
    options: ['main.dart', 'pubspec.yaml', 'AndroidManifest.xml', 'analysis_options.yaml'],
    correctIndex: 1,
  ),
  Question(
    text: 'Perintah terminal untuk menjalankan aplikasi Flutter adalah...',
    options: ['flutter build', 'flutter create', 'flutter run', 'flutter clean'],
    correctIndex: 2,
  ),
  Question(
    text: 'Class apa yang dipakai untuk membaca ukuran layar perangkat?',
    options: ['MediaQuery', 'Navigator', 'Theme', 'Scaffold'],
    correctIndex: 0,
  ),
  Question(
    text: 'Method apa yang dipakai untuk berpindah ke halaman baru?',
    options: ['Navigator.pop()', 'showDialog()', 'setState()', 'Navigator.push()'],
    correctIndex: 3,
  ),
  Question(
    text: 'Widget root yang menyediakan tema dan navigasi Material Design adalah...',
    options: ['Container', 'MaterialApp', 'SizedBox', 'Text'],
    correctIndex: 1,
  ),
  Question(
    text: 'Method pada ChangeNotifier untuk memberi tahu listener bahwa data berubah adalah...',
    options: ['setState()', 'runApp()', 'notifyListeners()', 'build()'],
    correctIndex: 2,
  ),
];