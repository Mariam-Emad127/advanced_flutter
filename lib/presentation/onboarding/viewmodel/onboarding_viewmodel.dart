import 'dart:async';

import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class OnBoardingViewModel extends BaseViewModel
    implements OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  StreamController streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void start() {
    _list = _getSliderData();
 _postDataToView();
  }

  @override
  void dispose() {
    streamController.close();
  }

  @override
  int goNext() {
   int nextIndex= ++_currentIndex; 
    if(nextIndex==_list.length){
      nextIndex=0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previosIndex=--_currentIndex; 
    if(previosIndex==-1){
      previosIndex=_list.length-1;
    }
    return previosIndex;
  }

  @override
  void onPageChanged(int index) {
 _currentIndex=index;
 _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => streamController.sink;

  @override
   
  Stream<SliderViewObject> get outputSliderViewObject =>
      streamController.stream.map((sliderViewObject) => sliderViewObject); 

 void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  List<SliderObject> _getSliderData () => [
        SliderObject(
            AppStrings.onBoardingTitle1.tr(),
            AppStrings.onBoardingSubTitle1.tr(),
            ImageAssets.onboardingLogo1),
        SliderObject(
            AppStrings.onBoardingTitle2.tr(),
            AppStrings.onBoardingSubTitle2.tr(),
            ImageAssets.onboardingLogo2),
        SliderObject(
            AppStrings.onBoardingTitle3.tr(),
            AppStrings.onBoardingSubTitle3.tr(),
            ImageAssets.onboardingLogo3),
        SliderObject(
            AppStrings.onBoardingTitle4.tr(),
            AppStrings.onBoardingSubTitle4.tr(),
            ImageAssets.onboardingLogo4)
      ];
}

abstract class OnBoardingViewModelInputs {
  int goNext(); // when user clicks on right arrow or swipe left
  int goPrevious(); // when user clicks on left arrow or swipe right
  void onPageChanged(int index);
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}
