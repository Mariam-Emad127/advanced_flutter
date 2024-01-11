 import 'package:advanced_flutter/data/response/responses.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:advanced_flutter/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
 

part 'app_api.g.dart';
@RestApi(baseUrl:"https://5zky3.wiremockapi.cloud/")
 
//@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
factory AppServiceClient(Dio dio,{String baseUrl})=_AppServiceClient; 

@POST("/customers/login")
 
Future<AuthenticationResponse>login(
@Field("email") String email,
@Field("password")String password);

}