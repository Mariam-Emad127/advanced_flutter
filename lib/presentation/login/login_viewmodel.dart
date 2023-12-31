import 'dart:async';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_classes.dart';

class LoginViewModel
    implements BaseViewModel, LoginViewModelInput, LoginViewModelOutput {
  StreamController _userNamestreamController =
      StreamController<String>.broadcast();
  StreamController _passwordstreamController =
      StreamController<String>.broadcast();
  StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  var loginObject = LoginObject("userName", "password");

 
LoginViewModel();
  @override
  void dispose() {
    _passwordstreamController.close();
    _userNamestreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordstreamController.sink;

  @override
  Sink get inputUserName =>  _userNamestreamController.sink;

  @override
  login() async {
    //(
      /* await loginUseCase.excute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold((failure) => {print(failure.message)}, (data) {
      print(data.customer!.name);
    }); */
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

/*   Stream<String> get outputIsUserNameValid => _passwordstreamController.stream.map((password) => _isPasswordValid(password));

String _isPasswordValid2(String password){

if(password.isNotEmpty){

  return "";
}else{

  return "please enter y password";
}
 */
//}