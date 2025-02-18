import 'package:advanced_flutter/data/data_source/local_data_source.dart';
import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/data/network/error_handler.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

  class RepositoryImpl implements Repository  {
  RemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  LocalDataSource localDataSource;
  RepositoryImpl(this.remoteDataSource, this.networkInfo,this.localDataSource);

  
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

      return left((ErrorHandler.handle(error).failure ));
    
   }} else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


 @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        // its safe to call API
        final response = await remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return right
          return Right(response.toDomain());
        } else {
          // failure
          // return left
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        } } catch (error) {
        return Left(ErrorHandler.handle(error).failure  );
      }} else {
      // return network connection error
      // return left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest)async {
  if(await networkInfo.isConnected){
try{
final response= await remoteDataSource.register(registerRequest);
if ( response.status==ApiInternalStatus.SUCCESS){

  return Right(response.toDomain());
}else{
 return Left(Failure(response.status??ResponseCode.DEFAULT,
   response.message??ResponseMessage.DEFAULT));
  
  }}catch(error){
return left(ErrorHandler.handle(error).failure);
   }} else {
      // return network connection error
      // return left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
  @override
  Future<Either<Failure, HomeObject>> getHomeData()async {
try{
final response=await localDataSource.getHomeData();
return Right(response.toDomain() );


}catch(error){
 if(await networkInfo.isConnected){
try{
final response=await remoteDataSource.getHomeData();
if(response.status==ApiInternalStatus.SUCCESS){

  localDataSource.saveHomeToCache(response);
  return Right( response.toDomain());

}else{
return Left(Failure(response.status??ResponseCode.DEFAULT, response.message??ResponseMessage.DEFAULT));

}}catch(error){
  return left(ErrorHandler.handle(error).failure);
}}else{
return left(DataSource.NO_INTERNET_CONNECTION.getFailure());

}}
  }
  
  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails()async {
try{
final response=await localDataSource.getStoreDetails  ();
return Right(response.toDomain() );


}catch(error){

 if(await networkInfo.isConnected){
try{
final response=await remoteDataSource.getStoreDetails();
if(response.status==ApiInternalStatus.SUCCESS){

  return Right(response.toDomain());
}else{
  return left(Failure(response.status??ResponseCode.DEFAULT, response.message??ResponseMessage.DEFAULT));
}

}catch(error){

    return left(ErrorHandler.handle(error).failure);
}}else{
return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
}

 }
  }}
 
  


  
  
  
