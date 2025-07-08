import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class FileLogOutput extends LogOutput {
  late final File _logFile;
  bool _initialized = false;

  Future<void> _init() async {
    if (_initialized) return;
    final dir = await getApplicationDocumentsDirectory();
    _logFile = File('${dir.path}/app_logs.txt');
    if (!(await _logFile.exists())) {
      await _logFile.create();
    }
    _initialized = true;
  }

  @override
  void output(OutputEvent event) async {
    await _init();
    final message = '${event.lines.join('\n')}\n';
    await _logFile.writeAsString(message, mode: FileMode.append);
  }

  Future<File> get logFile async {
    await _init();
    return _logFile;
  }
}
