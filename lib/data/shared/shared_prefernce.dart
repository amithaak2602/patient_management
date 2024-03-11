import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  late SharedPreferences pref;
  Future<SharedPreferences> loadPref() async {
    pref = await SharedPreferences.getInstance();
    return pref;
  }

}
