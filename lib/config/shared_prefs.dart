import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSingleton {
  static SharedPreferencesSingleton? _instance;
  static SharedPreferences? _sharedPreferences;

  SharedPreferencesSingleton._();

  factory SharedPreferencesSingleton() {
    _instance ??= SharedPreferencesSingleton._();
    return _instance!;
  }

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    return _sharedPreferences!;
  }
}
