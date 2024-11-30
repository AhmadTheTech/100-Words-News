import 'dart:convert';

SignupUpdateUserDetailsResult signupUpdateUserDetailsResultFromJson(String str) => SignupUpdateUserDetailsResult.fromJson(json.decode(str));

String signupUpdateUserDetailsResultToJson(SignupUpdateUserDetailsResult data) => json.encode(data.toJson());

class SignupUpdateUserDetailsResult {
  SignupUpdateUserDetailsResult({
    required this.status,
    required this.data,
    required this.result,
  });

  String status;
  String data;
  bool result;

  factory SignupUpdateUserDetailsResult.fromJson(Map<String, dynamic> json) => SignupUpdateUserDetailsResult(
        status: json["Status"] == null ? null : json["Status"],
        data: json["data"] == null ? null : json["data"],
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status == null ? null : status,
        "data": data == null ? null : data,
        "result": result == null ? null : result,
      };
}
