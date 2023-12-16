import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/constants_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBordingView extends StatefulWidget {
  const OnBordingView({super.key});

  @override
  State<OnBordingView> createState() => _OnBordingViewState();
}

class _OnBordingViewState extends State<OnBordingView> {
  final PageController pageController = PageController();
  OnBoardingViewModel viewModel = OnBoardingViewModel();

  _bind() {
    viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

//SliderViewObject sliderViewObject
  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark),
        ),
        body: PageView.builder(
            controller: pageController,
            itemCount: sliderViewObject.numOfSlides,
            onPageChanged: (index) {
              viewModel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
                return OnBoardingPage(sliderViewObject.sliderObject);
            }),

            bottomSheet: Container(color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),

              _getBottomSheetWidget(sliderViewObject)
          ])    
              ),
      );
    }


  }


 Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
              onTap: () {
                // go to previous slide
                pageController.animateToPage(viewModel.goPrevious(),
                    duration:   Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
            ),
          )

// circle indicator

          // right arrow
          ,
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
                child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.rightArrowIc),
                ),
                onTap: () {
                  // go to previous slide
                  pageController.animateToPage(viewModel.goNext(),
                      duration: const Duration(
                          milliseconds: AppConstants.sliderAnimationTime),
                      curve: Curves.bounceInOut);
                }),
          )
        ],
      ),
    );
  }

Widget _getProperCircle(int index,int currentIndex){
if(index==currentIndex){
return SvgPicture.asset(ImageAssets.hollowCircleIc);
}
else{
return SvgPicture.asset(ImageAssets.solidCircleIc);
}





}


    @override
    void dispose() {
      viewModel.dispose();
      super.dispose();
    }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  //const OnBoardingPage({super.key,   this.sliderObject});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(height: AppSize.s40),
      Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          _sliderObject.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          _sliderObject.subTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      const SizedBox(height: AppSize.s60),
      SvgPicture.asset(_sliderObject.image)
    ]);
  }


 


}
