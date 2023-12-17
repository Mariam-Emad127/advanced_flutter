import 'package:advanced_flutter/presentation/resources/langauge_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED = "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
class AppPreferences {

SharedPreferences _sharedPreferences;
AppPreferences(this._sharedPreferences);

Future<String>getAppLanguage ()async{
String? languge=_sharedPreferences.getString(PREFS_KEY_LANG);
if(languge !=null&&languge.isNotEmpty){
  return languge;

}else{
return LanguageType.ENGLISH.getValue();

}


}}