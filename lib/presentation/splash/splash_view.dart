import 'dart:async';

import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
Timer? timer;

_startDelay(){

  timer=Timer(Duration(seconds: 1), _getNext);
}

_getNext(){

  Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
}
@override
  void initState() {
  _startDelay();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: ColorManager.primary,
body:Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),

    );
  
  }
@override
  void dispose() {
   timer?.cancel();
    super.dispose();
  }

}