class OptVerificationMc {
  String? userOtp;

  OptVerificationMc({this.userOtp});

  OptVerificationMc.fromJson(Map<String, dynamic> json) {
    userOtp = json['user_otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_otp'] = userOtp;
    return data;
  }
}
