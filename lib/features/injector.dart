import 'package:mood_log_tests/features/chat/chat_dependencies.dart';
import 'package:mood_log_tests/features/user/user_dependencies.dart';

export 'useless_facts/useless_fact_injector.dart';
export 'logger/logger_injector.dart';
export 'user/user_dependencies.dart';

void initDependencies() {
  initChatDependency();
  initUserDependencies();
}
