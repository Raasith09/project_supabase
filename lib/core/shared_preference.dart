import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<SharedPreferences> getSharedPrefInstance() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }
}


// class SharedPreferencesGotrueStorage {
//   final SharedPreferences _prefs;

//   SharedPreferencesGotrueStorage(this._prefs);

//   Future<void> removeItem({required String key}) async {
//     await _prefs.remove(key);
//   }

//   Future<void> setItem({required String key, required String value}) async {
//     await _prefs.setString(key, value);
//   }

//   Future<String?> getItem({required String key}) async {
//     return _prefs.getString(key);
//   }

//   Future<void> clearItem() async {
//     await _prefs.clear();
//   }
// }