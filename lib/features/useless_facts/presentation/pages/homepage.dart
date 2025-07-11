import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_log_tests/config/theme/app_theme.dart';
import 'package:mood_log_tests/config/theme/theme_notifier.dart';
import 'package:mood_log_tests/core/util/app_loger.dart';
import 'package:mood_log_tests/features/useless_facts/presentation/widgets/useless_fact_card.dart';
import 'package:share_plus/share_plus.dart';

import '../../../injector.dart';

class UselessFactPresentor extends ConsumerWidget {
  const UselessFactPresentor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = MediaQuery.of(context).size;
    final uselessFactController = ref.read(uselessFactProvider.notifier);
    final loggerCtrl = ref.read(logControllerProvider.notifier);
    final themeCtrl = ref.read(themeProvider.notifier);
    final logPalette = Theme.of(context).extension<LogPalette>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Useless Fact"),
        actions: [
          IconButton(
            onPressed: () {
              themeCtrl.toggle();
            },
            icon: Icon(themeCtrl.isLight ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: SizedBox(
        width: screen.width,
        height: screen.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final uselessFactState = ref.watch(uselessFactProvider);
                  final logger = ref.watch(logControllerProvider);
                  if (uselessFactState.isInitial) {
                    return SizedBox(
                      width: screen.width,
                      child: Center(
                        child: Text("Press the button to know a fact!"),
                      ),
                    );
                  } else if (uselessFactState.isLoading) {
                    return SizedBox(
                      width: screen.width,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (uselessFactState.isFailure) {
                    return SizedBox(
                      width: screen.width,
                      child: Center(
                        child: Text("ERROR!:${uselessFactState.message}"),
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          UselessFactCard(
                            text: uselessFactState.uselessFact!.text!,
                          ),
                          if (logger.logs.isNotEmpty)
                            ...List.generate(logger.logs.length, (index) {
                              return Text(
                                "${logger.logs[index].message} [${logger.logs[index].timestamp}]",
                                style: TextStyle(color: logPalette!.logColor),
                              );
                            }),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                uselessFactController.getAFact();
                loggerCtrl.addLog("Fetch Log Pressed");
              },
              child: Text("Get a Useless Fact"),
            ),
            ElevatedButton(
              onPressed: () async {
                final file = await AppLogger.getLogFile();
                final xfile = XFile(file.path);
                await SharePlus.instance.share(ShareParams(files: [xfile]));
              },
              child: Text("Share Log"),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
