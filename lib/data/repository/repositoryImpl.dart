import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/data/network/error_handler.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

abstract class RepositoryImpl implements Repository  {
  RemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  RepositoryImpl(this.remoteDataSource, this.networkInfo);

  
  @override
  Future<Either<Failure, Authentication>> login(
 LoginRequest loginRequest) async {
    if (await networkInfo.isConnected) {
try{

      final response = await remoteDataSource.login(loginRequest);
      if (response.status == ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return left(Failure(ApiInternalStatus.FAILURE, response.message ?? ResponseMessage.DEFAULT));
      }
    }catch(error){ 

      return left(ErrorHandler.handle(error).failure);
    
   }} else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  }
 

