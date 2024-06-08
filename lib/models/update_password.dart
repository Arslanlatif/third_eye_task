class UpdatePasswordMc {
  String? userEmail;
  String? userId;
  String? newPassword;

  UpdatePasswordMc({this.userEmail, this.userId, this.newPassword});

  UpdatePasswordMc.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
    userId = json['user_id'];
    newPassword = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_email'] = userEmail;
    data['user_id'] = userId;
    data['new_password'] = newPassword;
    return data;
  }
}
