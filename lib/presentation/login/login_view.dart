import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel loginViewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
 final AppPreferences _appPreferences=instance<AppPreferences>();

  _bind() {
    loginViewModel.start();
    _userNameController.addListener(
        () => loginViewModel.setUserName(_userNameController.text));
    _passwordController.addListener(() {
      loginViewModel.setPassword(_passwordController.text);

      loginViewModel.isUserLoggedInSuccessfullyStreamController.stream
          .listen((isLogIn) {
        if (isLogIn == true) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
_appPreferences.setIsUserLoggedIn();
            Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
          });
        }
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
         body: StreamBuilder<FlowState>(
            stream: loginViewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    loginViewModel.login();
                  }) ??
                  _getContentWidget();
            }));
  }

  Widget _getContentWidget() {
    return Container(
        padding: EdgeInsets.only(top: AppPadding.p100),
        child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  Image(
                    image: AssetImage(ImageAssets.splashLogo),
                  ),
                  SizedBox(height: AppSize.s28),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: loginViewModel.outputIsUserNameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                              hintText: AppStrings.username,
                              labelText: AppStrings.username,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.usernameError),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: AppSize.s28),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: loginViewModel.outputIsPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password,
                              labelText: AppStrings.password,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.passwordError),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: AppSize.s28),
                  Padding(
                      padding: EdgeInsets.only(
                          left: AppPadding.p28, right: AppPadding.p28),
                      child: StreamBuilder<bool>(
                        stream: loginViewModel.outputIsAllInputsValid,
                        builder: (context, snapshot) {
                          return SizedBox(
                            width: double.infinity,
                            height: AppSize.s40,
                            child: ElevatedButton(
                                onPressed: (snapshot.data ?? false)
                                    ? () {
                                        loginViewModel.login();
                                      }
                                    : null,
                                child: Text(AppStrings.login)),
                          );
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppPadding.p8,
                      left: AppPadding.p28,
                      right: AppPadding.p28,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.forgotPasswordRoute   );
                          },
                          child: Text(AppStrings.forgtPassword,
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.registerRoute);
                          },
                          child: Text(AppStrings.registerText,
                              style: Theme.of(context).textTheme.titleMedium),
                        )
                      ],
                    ),
                  )
                ]))));
  }

  @override
  void dispose() {
    loginViewModel.dispose();
  }
}
