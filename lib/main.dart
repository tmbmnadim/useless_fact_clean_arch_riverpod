import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_log_tests/config/theme/theme_notifier.dart';

import 'features/useless_facts/presentation/pages/homepage.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: UselessFactPresentor(),
    );
  }
}
