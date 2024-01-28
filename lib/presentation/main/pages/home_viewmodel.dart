import 'dart:async';
import 'dart:ffi';
import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/domain/usecase/home_usecase.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel implements HomeViewModelInputs,HomeViewModelOutputs{
/* final StreamController _bannerStreamController =BehaviorSubject<List<BannerAd>> ();
final StreamController _storeStreamController =BehaviorSubject<List<Store>>();
final StreamController _servicesStreamController =BehaviorSubject<List<Service>>(); */
  final _dataStreamController = BehaviorSubject<HomeViewObject>();

final HomeUseCase _homeUseCase;
HomeViewModel(this._homeUseCase);
  @override
  void start() {
 _getHomeData();
  }


  @override
  void dispose() {
/* _bannerStreamController.close();
_servicesStreamController.close();
_storeStreamController.close(); */
    super.dispose();
  }
 /*  
  @override
  // TODO: implement inputBabber
  Sink get inputBabber => _bannerStreamController.sink;
  
  @override
  // TODO: implement inputService
  Sink get inputService => _servicesStreamController.sink;
  
  @override
  // TODO: implement inputStore
  Sink get inputStore => _storeStreamController.sink;
  
  @override
  // TODO: implement outputBannerAd
  Stream<List<BannerAd>> get outputBannerAd => _bannerStreamController.stream.map((banner) => banner);
  
  @override
   Stream<List<Service>> get outputService => _servicesStreamController.stream.map((servic) => servic);
  
  @override
  // TODO: implement outputStore
  Stream<List<Store>> get outputStore => _storeStreamController.stream.map((store) => store);
 */
_getHomeData()async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (
    await _homeUseCase.excute(Void)
    )
        .fold(
            (failure) => {
                  // left -> failure
                  inputState.add(ErrorState(
                      stateRendererType: StateRendererType.POPUP_ERROR_STATE, message: failure.message))
                }, (homeObject) {
      // right -> success (data)
      inputState.add(ContentState());
/* inputBabber.add(homeObject.data.banners);
inputService.add(homeObject.data.services);
inputStore.add(homeObject.data.stores); */
   inputHomeData.add(HomeViewObject(homeObject.data.stores,
          homeObject.data.services, homeObject.data.banners));
      // navigate to main screen after the login
 
 
     });


}

  @override
  // TODO: implement inputHomeData
  Sink get inputHomeData => _dataStreamController.sink;

  @override
  // TODO: implement outputHomeData
  Stream<HomeViewObject> get outputHomeData => _dataStreamController.stream.map((data) => data);


}

abstract class HomeViewModelInputs {
 /*   Sink get inputStore;
  Sink get inputService;
  Sink get inputBabber ;*/
    Sink get inputHomeData;

}

abstract class HomeViewModelOutputs {
/*   Stream<List<Store>> get outputStore;
  Stream<List<Service>> get outputService;
  Stream<List<BannerAd>> get outputBannerAd; */
    Stream<HomeViewObject> get outputHomeData;

}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}