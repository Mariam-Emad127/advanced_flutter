class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}




class RegisterRequest {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String profilePicture;
  String mobileNumber;

  RegisterRequest(this.countryMobileCode, this.userName, this.email,
      this.password, this.profilePicture,this.mobileNumber);
}