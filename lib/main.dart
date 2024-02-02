import 'package:advanced_flutter/app/app.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/resources/langauge_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();

  runApp(EasyLocalization(
 
    supportedLocales: [ARABIC_LOCAL,ENGLISH_LOCAL],
     path: ASSETS_PATH_LOCALISATIONS,
      
     child:Phoenix( child: MyApp())
  
  ));
}
