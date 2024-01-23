
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
     Repository _repository;

  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> excute(void input) async{

return await _repository.getHomeData();
  }


}