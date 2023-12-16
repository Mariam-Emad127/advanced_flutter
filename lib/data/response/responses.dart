import 'package:json_annotation/json_annotation.dart';
 

//part 'responses.g.dart';
part 'responses.g.dart';
@JsonSerializable()
class BaseResponse{
@JsonKey(name: "status")
int ?status;
@JsonKey(name: "message")
String? message;

}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse(this.id, this.name, this.numOfNotifications);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);
    Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);    

}


@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
    ContactsResponse(this.phone,this.email,this.link);

  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>  _$ContactsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);       
  
  }

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
@JsonKey(name: "customer")
CustomerResponse?customer;
@JsonKey(name: "contact")
ContactsResponse?contact;

AuthenticationResponse(this.contact,this.customer);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthinticationResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$AuthinticationResponseToJson(this);

}