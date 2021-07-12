import 'package:locally/redux/initialRunChecker/initial_run_check_sharedPreference.dart';

class InitialRunCheckState {
  late Future<bool> isInitialRun;
  InitialRunCheckState({required this.isInitialRun});
  factory InitialRunCheckState.initial() => InitialRunCheckState(
      isInitialRun: InitialRunDataForAppState().getBooleanValue());
}
