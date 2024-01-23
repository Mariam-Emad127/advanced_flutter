import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/app/extention.dart';
import 'package:advanced_flutter/data/response/responses.dart';
import 'package:advanced_flutter/domain/models/models.dart';
 
extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? "",
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contact.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse {
  String toDomain() {
    return this?.support.orEmpty() ?? Constants.empty;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
        this?.id?.orZero() ?? Constants.zero,
        this?.title?.orEmpty() ?? Constants.empty,
        this?.image?.orEmpty() ?? Constants.empty);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
        this?.id?.orZero() ?? Constants.zero,
        this?.title?.orEmpty() ?? Constants.empty,
        this?.image?.orEmpty() ?? Constants.empty);
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(
        this?.id?.orZero() ?? Constants.zero,
        this?.title?.orEmpty() ?? Constants.empty,
        this?.image?.orEmpty() ?? Constants.empty,
        this?.link?.orEmpty() ?? Constants.empty);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services = (this
                ?.data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            Iterable.empty())
        .cast<Service>()
        .toList();
    List<BannerAd> banners = (this
                ?.data
                ?.banners
                ?.map((bannerResponse) => bannerResponse.toDomain()) ??
            Iterable.empty())
        .cast<BannerAd>()
        .toList();
    List<Store> stores =
        (this?.data?.stores?.map((storeResponse) => storeResponse.toDomain()) ??
                Iterable.empty())
            .cast<Store>()
            .toList();
    var data = HomeData(services, stores,banners);
    return HomeObject(data);
  }
}
