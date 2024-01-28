import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/data/data_source/local_data_source.dart';
import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/network/app_api.dart';
import 'package:advanced_flutter/data/network/dio_factory.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/repository/repositoryImpl.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/forgot_password_usecase.dart';
import 'package:advanced_flutter/domain/usecase/home_usecase.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/domain/usecase/register_usecase.dart';
import 'package:advanced_flutter/domain/usecase/store_details_usecase.dart';
import 'package:advanced_flutter/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:advanced_flutter/presentation/main/pages/home_viewmodel.dart';
import 'package:advanced_flutter/presentation/register/register_viewmodel.dart';
import 'package:advanced_flutter/presentation/store_details/store_detailsViewModel.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
  
 
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

   //local data source
  instance.registerLazySingleton<LocalDataSource>(
     () => LocalDataSourceImplementer());

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(),instance() ));
}
 

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}


initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}


initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
        () => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
  
    instance.registerFactory<ImagePicker>(
        () => ImagePicker());
  }
}


initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(() => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(() => StoreDetailsViewModel(instance()));
  }
}


resetModules() {
  instance.reset(dispose: false);
  initAppModule();
  //initHomeModule();
  initLoginModule();
  //initRegisterModule();
  initForgotPasswordModule();
 initStoreModule();
}