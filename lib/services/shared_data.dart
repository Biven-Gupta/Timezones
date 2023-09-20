import 'package:shared_preferences/shared_preferences.dart';

class TimezoneSharedPreferences {
  static SharedPreferences? _preferences;
  static const _keyValue = 'country';
  static const _keyFlag = 'flag';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  Future setTimezone(String zone) async =>
      await _preferences?.setString(_keyValue, zone);

  Future setFlag(int flag) async => await _preferences?.setInt(_keyFlag, flag);

  String? getTimezone() => _preferences?.getString(_keyValue);

  int? getFlag() => _preferences?.getInt(_keyFlag);
}
