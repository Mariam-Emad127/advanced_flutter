 import 'package:advanced_flutter/data/response/responses.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:advanced_flutter/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
 

part 'app_api.g.dart';
@RestApi(baseUrl:"https://5zky3.wiremockapi.cloud/")
//mocklab.io")
//wiremockapi.cloud/")
 //@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
factory AppServiceClient(Dio dio,{String baseUrl})=_AppServiceClient; 

@POST("/customers/login")
 
Future<AuthenticationResponse>login(
@Field("email") String email,
@Field("password")String password);


@POST( "/customers/forgotPassword")
Future <ForgotPasswordResponse>forgotPassword(@Field("email")String email);
 
   @POST("/customers/register")
  Future<AuthenticationResponse> register(
    @Field("country_mobile_code") String countryMobileCode,
    @Field("user_name") String userName,
    @Field("email") String email,
    @Field("password") String password,
    @Field("mobile_number") String mobilNumber,
    @Field("profile_picture") String profilePicture,
  );


@GET("/home")
Future<HomeResponse>getHomeData();


@GET( "/storeDetails/1")
Future <StoreDetailsResponse>getStoreDetails();
}