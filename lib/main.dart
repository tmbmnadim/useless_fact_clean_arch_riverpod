import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:mood_log_tests/config/theme/theme_notifier.dart';
import 'package:mood_log_tests/features/chat/presentation/chat.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return GetMaterialApp(title: 'Useless', theme: theme, home: ChatScreen());
  }
}
