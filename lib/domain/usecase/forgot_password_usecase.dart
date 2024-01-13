import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
   final Repository _repository;

ForgotPasswordUseCase(this._repository); 
  @override
  Future<Either<Failure, String>> excute(String input) async{
return await _repository.forgotPassword(input);
  }
}