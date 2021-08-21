import 'package:connect_store/api/api_settings.dart';
import 'package:connect_store/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefController {
  final String isRegisteredKey = 'isRegistered';
  final String isActivatedKey = 'isActivated';
  final String isLoggedInKey = 'isLoggedIn';
  final String tokenKey = 'token';

  static final UserPrefController _instance = UserPrefController._internal();
  late SharedPreferences _sharedPreferences;

  UserPrefController._internal();

  factory UserPrefController() {
    return _instance;
  }

  Future<void> initSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  SharedPreferences get pref => _sharedPreferences;

  //Is Registered
  Future<bool> setIsRegistered(bool isRegistered) async {
    return await _sharedPreferences.setBool(isRegisteredKey, isRegistered);
  }

  bool get isRegistered => _sharedPreferences.getBool(isRegisteredKey) ?? false;

  //Is Activated
  Future<bool> setIsActivated(bool isActivated) async {
    return await _sharedPreferences.setBool(isActivatedKey, isActivated);
  }

  bool get isActivated => _sharedPreferences.getBool(isActivatedKey) ?? false;

  //Is LoggedIn
  bool get isLoggedIn => _sharedPreferences.getBool(isLoggedInKey) ?? false;

  Future<bool> clear() async {
    return await _sharedPreferences.remove(isRegisteredKey) &&
        await _sharedPreferences.remove(isActivatedKey) &&
        await _sharedPreferences.remove(isLoggedInKey) &&
        await _sharedPreferences.remove(tokenKey) &&
        await _sharedPreferences.remove(ApiSettings.EMAIL) &&
        await _sharedPreferences.remove(ApiSettings.PASSWORD) &&
        await _sharedPreferences.remove(ApiSettings.MOBILE) &&
        await _sharedPreferences.remove(ApiSettings.GENDER) &&
        await _sharedPreferences.remove(ApiSettings.CITY_ID) &&
        await _sharedPreferences.remove(ApiSettings.STORE_ID) &&
        await _sharedPreferences.remove(tokenKey) &&
        await _sharedPreferences.remove(ApiSettings.NAME);
  }

  Future<void> save({required User user,required String password}) async {
    await _sharedPreferences.setBool(isLoggedInKey, true);
    // await _sharedPreferences.setInt('id', user.id);
    await _sharedPreferences.setString(ApiSettings.EMAIL, user.email!);
    await _sharedPreferences.setString(ApiSettings.MOBILE, user.mobile);
    await _sharedPreferences.setString(ApiSettings.PASSWORD, password);
    await _sharedPreferences.setString(ApiSettings.GENDER, user.gender);
    await _sharedPreferences.setInt(ApiSettings.CITY_ID, user.cityId);
    await _sharedPreferences.setInt(ApiSettings.STORE_ID, user.storeId);
    await _sharedPreferences.setString(ApiSettings.NAME, user.name);
    await _sharedPreferences.setString(
        tokenKey, "${user.tokenType +' '+ user.token}");
  }

  /*
  *   late int id;
  late String name;
  late String? email;
  late String mobile;
  late String gender;
  late bool active;
  late bool verified;
  late int cityId;
  late int storeId;
  late String token;
  late String tokenType;
  late String refreshToken;
  late City city;
  *
  *
  * */

  String get token => _sharedPreferences.getString(tokenKey) ?? '';
  String get password => _sharedPreferences.getString(ApiSettings.PASSWORD) ?? '';
  User get user {
    User user = User();
    // user.id = _sharedPreferences.getInt('id') ?? 0;
    user.name = _sharedPreferences.getString(ApiSettings.NAME) ?? '';
    user.email = _sharedPreferences.getString(ApiSettings.EMAIL) ?? '';
    user.mobile = _sharedPreferences.getString(ApiSettings.MOBILE) ?? '';
    user.gender = _sharedPreferences.getString(ApiSettings.GENDER) ?? '';
    user.cityId = _sharedPreferences.getInt(ApiSettings.CITY_ID) ?? 0;
    user.storeId = _sharedPreferences.getInt(ApiSettings.STORE_ID) ?? 0;
    user.token = _sharedPreferences.getString(tokenKey) ?? '';
    return user;
  }

  Future<bool> logout() async {
    return await this.clear();
  }
}
