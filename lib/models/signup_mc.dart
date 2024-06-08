class SignUpMc {
  String? userName;
  String? userEmail;
  String? userPassword;

  SignUpMc({this.userName, this.userEmail, this.userPassword});

  SignUpMc.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPassword = json['user_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_password'] = userPassword;
    return data;
  }
}











// import 'dart:convert';

// class SignUpMc {
//   final String userName;
//   final String userEmail;
//   final String userPassword;

//   SignUpMc({
//     required this.userName,
//     required this.userEmail,
//     required this.userPassword,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'user_name': userName,
//       'user_email': userEmail,
//       'user_password': userPassword,
//     };
//   }

//   factory SignUpMc.fromMap(Map<String, dynamic> map) {
//     return SignUpMc(
//       userName: map['user_name'] as String,
//       userEmail: map['user_email'] as String,
//       userPassword: map['user_password'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory SignUpMc.fromJson(String source) =>
//       SignUpMc.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() =>
//       'UserSignUp(user_name: $userName, user_email: $userEmail, user_password: $userPassword)';
// }
