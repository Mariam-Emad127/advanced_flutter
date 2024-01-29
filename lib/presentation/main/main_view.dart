import 'package:advanced_flutter/presentation/main/pages/home_page.dart';
import 'package:advanced_flutter/presentation/main/pages/notifications_page.dart';
import 'package:advanced_flutter/presentation/main/pages/search_page.dart';
import 'package:advanced_flutter/presentation/main/pages/settings_page.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
    List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage()
  ];
   List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];
   var _title = AppStrings.home.tr();
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headline2,
        ).tr(),
      ),
body: pages[_currentIndex],
bottomNavigationBar: Container(
  decoration: BoxDecoration(boxShadow: [ BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1)]),
  
  child: BottomNavigationBar(
    selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex:_currentIndex,
          onTap:onTap ,
    items: [
  BottomNavigationBarItem(
                icon: Icon(Icons.home), label: AppStrings.home.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppStrings.search.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppStrings.notifications.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppStrings.settings.tr()),


    ],),
  
  
  ),

    );
 
  }
 

    onTap(int index){
setState(() {
  _currentIndex=index;
  _title=titles[index];
});


    }
  
}