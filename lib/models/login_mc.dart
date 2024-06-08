class LoginMc {
  String? userEmail;
  String? userPassword;
  String? isSocial;

  LoginMc({this.userEmail, this.userPassword, this.isSocial});

  LoginMc.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
    userPassword = json['user_password'];
    isSocial = json['is_social'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_email'] = userEmail;
    data['user_password'] = userPassword;
    data['is_social'] = isSocial;
    return data;
  }
}
