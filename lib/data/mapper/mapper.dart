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


extension ForgotPasswordResponseMapper on ForgotPasswordResponse{

String toDomain(){

return this?.support.orEmpty() ?? Constants.empty;
}

}

