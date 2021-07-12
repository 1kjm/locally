import 'package:locally/redux/appstate.dart';
import 'package:locally/redux/initialRunChecker/initial_run_check_actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialRunCheckMiddleWare {
  setValueOfInitialRunMiddleware() {
    return (Store<AppState> store, action, NextDispatcher next) async {
      if (action is ChangeInitialRunCheckValue) {
        print('ChangeInitialValue called');
        SharedPreferences myPrefs = await SharedPreferences.getInstance();
        myPrefs.setBool('key', false);
      }
      next(action);
    };
  }
}
