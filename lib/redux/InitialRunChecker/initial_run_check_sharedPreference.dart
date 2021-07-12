import 'package:shared_preferences/shared_preferences.dart';

class InitialRunDataForAppState {
  Future<bool> getBooleanValue() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    return myPrefs.getBool('key') ?? true;
  }
}
