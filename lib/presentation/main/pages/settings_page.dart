import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/data/data_source/local_data_source.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/langauge_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences appPreferences=instance<AppPreferences>();
  final LocalDataSource localDataSource=instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
     return ListView(
      padding: EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(
            AppStrings.changeLanguage.tr(),
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
          leading: SvgPicture.asset(ImageAssets.changeLangIc),
          trailing: 
          Transform(
            alignment: Alignment.center,
           transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: 
            SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
          ),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.contactUs.tr(),
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
          leading: SvgPicture.asset(ImageAssets.contactUsIc),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
         ),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.inviteYourFriends.tr(),
            style: Theme.of(context).textTheme.headline4,
          ).tr() ,
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
          trailing:  Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child:  SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
          ),
          onTap: () {
            _inviteFriends();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.logout.tr(),
            style: Theme.of(context).textTheme.headline4,
          ).tr() ,
          leading: SvgPicture.asset(ImageAssets.logoutIc),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
          ),
          onTap: () {
            _logout();
          },
        )
      ],
    );
  }

  
  bool isRtl() {
    return context.locale == ARABIC_LOCAL; // app is in arabic language
  }


 _changeLanguage(){
appPreferences.setLanguageChanged();
Phoenix.rebirth(context);

 }

  void _contactUs() {}

  
  void _inviteFriends() {}
   void _logout() {

    appPreferences.logout();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
localDataSource.clearCache();

   }

  }
