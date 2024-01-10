import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/network/app_api.dart';
import 'package:advanced_flutter/data/network/dio_factory.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/repository/repositoryImpl.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dio/dio.dart';
 
/* 
//final   instance=GetIt.instance;
final instance = GetIt.instance;

Future<void>initAppModule ()async{

final sharedPrefs=await SharedPreferences.getInstance();

instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
AppPreferences appPreferences=AppPreferences(sharedPrefs);

instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

//Dio dio=await  instance<DioFactory>().getDio();
  final dio = await instance<DioFactory>().getDio();


instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance()));

instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(),instance()));
 

 

}

 initLoginAppModule () async{
  if (GetIt.I.isRegistered<LoginUseCase>()){

instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance() ));
  }
} */



final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app  service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () =>   RemoteDataSourceImpl(instance()));

  // local data source
  //instance.registerLazySingleton<LocalDataSource>(
    //  () => LocalDataSourceImplementer());

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance() ));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}