import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advanced_flutter/presentation/main/pages/home_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manger.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  _bind() {
    _homeViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: StreamBuilder<FlowState>(
              stream: _homeViewModel.outputState,
              builder: (context, snapshot) {
                return
                    
                    snapshot.data?.getScreenWidget(
                            context, _getContentWidgets(), () {
                          _homeViewModel.start();
                        }) ??
                        _getContentWidgets();

           
              })),
    );
  }

  Widget _getContentWidgets() {
    return StreamBuilder<HomeViewObject>(
        stream: _homeViewModel.outputHomeData,
        builder: (context, snapshot) {
          return Column(
            children: [
              _getBannerWidget(snapshot.data?.banners),
              _getSection(AppStrings.services.tr()),
              _getServiceWidget(snapshot.data?.services),
              _getSection(AppStrings.services.tr()),
              _getStoreWidget(snapshot.data?.stores)
            ],
          );
        });
  }

  Widget _getSection(String title) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            top: AppPadding.p12,
            left: AppPadding.p12,
            right: AppPadding.p12,
            bottom: AppPadding.p2),
        child: Text(title),
      ),
    );
  }

/*   Widget _getBanner() {
    return StreamBuilder<List<BannerAd>>(
      stream: _homeViewModel.outputBannerAd,
      builder: (context, snapshot) {
        return _getBannerWidget(snapshot.data);
      },
    );
  }
 */
  Widget _getBannerWidget(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
          items: banners
              .map((banner) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSize.s1_5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                            color: ColorManager.primary, width: AppSize.s1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.network(
                          banner.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              height: AppSize.s90,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true));
    } else {
      return Container();
    }
  }

/*   Widget _getServise() {
    return StreamBuilder<List<Service>>(
      stream: _homeViewModel.outputService,
      builder: (context, snapshot) {
        return _getServiceWidget(snapshot.data);
      },
    );
  } */

  Widget _getServiceWidget(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
        ),
        child: Container(
          height: AppSize.s140,
          margin: EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map((service) => Card(
                      elevation: AppSize.s4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                            color: ColorManager.primary, width: AppSize.s1),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            child: Image.network(
                              service.image,
                              fit: BoxFit.cover,
                              height: AppSize.s100,
                              width: AppSize.s100,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: AppPadding.p8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                service.title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

/*  Widget _getStore() {
    return StreamBuilder<List<  Store>>(
      stream: _homeViewModel.outputStore ,
      builder: (context, snapshot) {
        return _getStoreWidget(snapshot.data);
      },
    );
  } */

  Widget _getStoreWidget(List<Store>? stores) {
    if (stores != null) {
      return Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
          top: AppPadding.p12,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSize.s2,
              mainAxisSpacing: AppSize.s8,
              crossAxisSpacing: AppSize.s8,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                  stores.length,
                  (index) => InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.storeDetailsRoute);
                        },
                        child: Card(
                          elevation: AppSize.s4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            side: BorderSide(
                                color: ColorManager.primary, width: AppSize.s1),
                          ),
                          child: Image.network(stores[index].image),
                        ),
                      )),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }
}


 
 