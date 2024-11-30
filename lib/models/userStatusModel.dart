import 'dart:convert';

class CheckUserStatusModel {
  bool showPaymentPage;

  CheckUserStatusModel({
    required this.showPaymentPage,
  });

  factory CheckUserStatusModel.fromRawJson(String str) => CheckUserStatusModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckUserStatusModel.fromJson(Map<String, dynamic> json) => CheckUserStatusModel(
    showPaymentPage: json["show_payment_page"],
  );

  Map<String, dynamic> toJson() => {
    "show_payment_page": showPaymentPage,
  };
}
