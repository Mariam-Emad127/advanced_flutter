import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/forgot_password/forget_password_view.dart';
//import 'package:advanced_flutter/presentation/forget_password/forget_password_view.dart';
import 'package:advanced_flutter/presentation/login/login_view.dart';
import 'package:advanced_flutter/presentation/main/main_view.dart';
import 'package:advanced_flutter/presentation/onboarding/view/onboarding_view.dart';
import 'package:advanced_flutter/presentation/register/register_view.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/splash/splash_view.dart';
import 'package:advanced_flutter/presentation/store_details/store_details_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
       
      case Routes.forgotPasswordRoute:
      initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPassword());

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBordingView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }
}

Route<dynamic> unDefinedRoute() {
  return MaterialPageRoute(
      builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.noRouteFound),
          ),
          body: Center(child: Text(AppStrings.noRouteFound))));
}
