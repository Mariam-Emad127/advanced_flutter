import 'package:advanced_flutter/presentation/resources/langauge_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";
class AppPreferences {
  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? languge = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (languge != null && languge.isNotEmpty) {
      return languge;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }
 Future<void> setLanguageChanged() async {
    String currentLanguage = await getAppLanguage();

if(currentLanguage==LanguageType.ARABIC.getValue()){

 _sharedPreferences.setString(PREFS_KEY_LANG,LanguageType.ARABIC.getValue());
}else{
 _sharedPreferences.setString(PREFS_KEY_LANG,LanguageType.ENGLISH.getValue());


}


 }
 
 Future<Locale> getLocal() async {
    String currentLanguage = await getAppLanguage();

  if(currentLanguage==LanguageType.ARABIC.getValue()){

return ARABIC_LOCAL;
}else{
return ENGLISH_LOCAL;

}
 }
 Future<void> setOnBoardingScreenViewed() async {
_sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);

 }

Future<bool> isOnBoardingScreenViewed() async {
return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN)??false;

 }

  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }

}
