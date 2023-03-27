import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences? sharedPreferences;
  static init()async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> setData({
    required String key,
    required dynamic value,
})async
  {
    if(value is String) return await sharedPreferences?.setString(key, value);
    else if(value is bool) return await sharedPreferences?.setBool(key, value);
    else if(value is int) return await sharedPreferences?.setInt(key, value);
    else await sharedPreferences?.setDouble(key, value);
    return null;
  }

  static dynamic getData({
    required String key,
})
  {
     sharedPreferences?.get(key);
  }

  static removeData({
    required String key,
})
  {
    sharedPreferences?.remove(key);
  }
}

