import 'dart:async';
import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';

class LoginViewModel
    extends BaseViewModel implements LoginViewModelInput, LoginViewModelOutput {
  StreamController _userNamestreamController =
      StreamController<String>.broadcast();
  StreamController _passwordstreamController =
      StreamController<String>.broadcast();
  StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController=StreamController();    
  var loginObject = LoginObject("", "");
  LoginUseCase _loginUseCase; 
  LoginViewModel(this._loginUseCase);
  @override
  void dispose() {
  // super.dispose();
    _passwordstreamController.close();
    _userNamestreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
     inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordstreamController.sink;

  @override
  Sink get inputUserName => _userNamestreamController.sink;

  @override
  login() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (
     await _loginUseCase.excute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold((failure) => {
          inputState.add(ErrorState(stateRendererType: StateRendererType.POPUP_ERROR_STATE, message: failure.message)),
          print(failure.message)}, 
          (data) {
            isUserLoggedInSuccessfullyStreamController.add( true);
            inputState.add(ContentState);
      print(data.customer!.name);
    }); 
  }

  @override
  Stream<bool> get outputIsPasswordValid => _passwordstreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNamestreamController.stream
      .map((username) => _isUserNameValid(username));

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String username) {
    return username.isNotEmpty;
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputIsAllInputValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
  }

  @override
  Sink get inputIsAllInputValid => _areAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((event) => _areAllInputsValid());

  bool _areAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }
}

abstract class LoginViewModelInput {
  setUserName(String userName);
  setPassword(String password);
  login();
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
