class ForgetPasswordMc {
  String? userEmail;

  ForgetPasswordMc({this.userEmail});

  ForgetPasswordMc.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_email'] = userEmail;
    return data;
  }
}
