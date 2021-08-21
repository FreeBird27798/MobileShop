import 'package:connect_store/api/api_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefController {
  final String isFirstTimeKey = 'isFirstTime';
  final String storeApiKey = 'STORE_API_KEY';
  final String langCodeKey = 'language_code';

  static final AppPrefController _instance = AppPrefController._internal();
  late SharedPreferences _sharedPreferences;


  AppPrefController._internal();

  factory AppPrefController() {
    return _instance;
  }

  Future<void> initSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setStoreApiKey(storeKey);
  }

  SharedPreferences get pref => _sharedPreferences;

  //Lang
  Future<bool> setLanguage(String languageCode) async {
    return await _sharedPreferences.setString(langCodeKey, languageCode);
  }

  String get languageCode {
    return _sharedPreferences.getString(langCodeKey) ?? 'en';
  }


  Future<bool> setStoreApiKey(String storeKey) async {
    return await _sharedPreferences.setString(
        storeApiKey, ApiSettings.STORE_API_KEY);
  }

  String get storeKey => _sharedPreferences.getString(storeApiKey) ?? '';

  //Is First Time
  Future<bool> setIsFirstTime(bool isFirstTime) async {
    return await _sharedPreferences.setBool(isFirstTimeKey, isFirstTime);
  }

  bool get isFirstTime => _sharedPreferences.getBool(isFirstTimeKey) ?? true;

}
