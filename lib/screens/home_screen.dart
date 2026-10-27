import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_assets.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/responsive_center.dart';
import '../widgets/theme_toggle_button.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    // Isi ulang dari Provider, jadi nama tidak hilang saat kembali ke sini.
    _nameController =
        TextEditingController(text: context.read<QuizProvider>().userName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Nama tidak boleh kosong';
    if (name.length < 2) return 'Nama minimal 2 karakter';
    return null;
  }

  void _startQuiz() {
    if (!_formKey.currentState!.validate()) return;

    final quiz = context.read<QuizProvider>();
    quiz.setUserName(_nameController.text);
    quiz.restartQuiz();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth > constraints.maxHeight;
            final padding = context.sp(24);
            final logoSize = (math.min(constraints.maxWidth, constraints.maxHeight) *
                (wide ? 0.5 : 0.35))
                .clamp(96.0, 240.0)
                .toDouble();

            final header = _buildHeader(context, logoSize);
            final form = _buildForm(context);

            return SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: ConstrainedBox(
                // Konten minimal setinggi layar supaya tetap di tengah.
                constraints: BoxConstraints(
                  minHeight: math.max(0, constraints.maxHeight - padding * 2),
                ),
                child: ResponsiveCenter(
                  alignment: Alignment.center,
                  maxWidth:
                  wide ? Breakpoints.maxWideWidth : Breakpoints.maxContentWidth,
                  child: wide
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: header),
                      SizedBox(width: context.sp(32)),
                      Expanded(child: form),
                    ],
                  )
                      : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      header,
                      SizedBox(height: context.sp(32)),
                      form,
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

  Widget _buildHeader(BuildContext context, double logoSize) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(AppAssets.logo, width: logoSize, height: logoSize),
        SizedBox(height: context.sp(16)),
        Text(
          AppStrings.appName,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.sp(30),
            fontWeight: FontWeight.w700,
            color: scheme.primary,
          ),
        ),
        SizedBox(height: context.sp(6)),
        Text(
          AppStrings.appTagline,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.sp(14),
            color: scheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(context.sp(14));

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            validator: _validateName,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _startQuiz(),
            style: TextStyle(fontSize: context.sp(16)),
            decoration: InputDecoration(
              labelText: AppStrings.inputNameLabel,
              hintText: AppStrings.inputNameHint,
              prefixIcon: const Icon(Icons.person_rounded),
              filled: true,
              fillColor: scheme.surface,
              border: OutlineInputBorder(borderRadius: radius),
              enabledBorder: OutlineInputBorder(
                borderRadius: radius,
                borderSide: BorderSide(
                  color: scheme.onSurface.withValues(alpha: 0.15),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: radius,
                borderSide: BorderSide(color: scheme.primary, width: context.sp(2)),
              ),
            ),
          ),
          SizedBox(height: context.sp(20)),
          CustomButton(
            label: AppStrings.startQuiz,
            icon: Icons.play_arrow_rounded,
            onPressed: _startQuiz,
          ),
        ],
      ),
    );
  }
}