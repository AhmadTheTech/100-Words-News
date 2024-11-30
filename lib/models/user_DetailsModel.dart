// import 'dart:convert';
//
// UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));
//
// String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());
//
// class UserDetailsModel {
//   UserDetailsModel(
//       {required this.userId,
//       required this.userDisplayName,
//       required this.userName,
//       required this.userEmail,
//       required this.userPhone,
//       required this.userAddress,
//       required this.userDob,
//       required this.userProfilePicture,
//       required this.userRegisteredOn,
//       required this.premiumStatus,
//       required this.autoPayments,
//       required this.subscriptionEndDate,
//       required this.nameOnCreditCard,
//       required this.creditCardNo,
//       required this.creditCardExpiry,
//       required this.creditCardCvc,
//       required this.zipcode});
//
//   int userId;
//   String userDisplayName;
//   dynamic userName;
//   dynamic userEmail;
//   dynamic userPhone;
//   dynamic userAddress;
//   dynamic userDob;
//   dynamic userProfilePicture;
//   dynamic userRegisteredOn;
//   dynamic premiumStatus;
//   dynamic autoPayments;
//   dynamic subscriptionEndDate;
//   dynamic nameOnCreditCard;
//   dynamic creditCardNo;
//   dynamic creditCardExpiry;
//   dynamic creditCardCvc;
//   dynamic zipcode;
//
//   factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
//         userId: json["user_id"] == null ? 'null' : json["user_id"],
//         userDisplayName: json["user_display_name"] == null ? null : json["user_display_name"],
//         userName: json["user_name"] == null ? 'null' : json["user_name"],
//         userEmail: json["user_email"] == null ? 'null' : json["user_email"],
//         userPhone: json["user_phone"] == null ? 'null' : json["user_phone"],
//         userAddress: json["user_address"] == null ? 'null' : json["user_address"],
//         userDob: json["user_dob"] == null ? 'null' : json["user_dob"],
//         userProfilePicture: json["user_profile_picture"] == null || json["user_profile_picture"] == false ? 'null' : json["user_profile_picture"],
//         userRegisteredOn: DateTime.parse(json["user_registered_on"]),
//         premiumStatus: json["premium_status"] == null ? 'null' : json["premium_status"],
//         autoPayments: json["auto_payments"] == null ? 'null' : json["auto_payments"],
//         subscriptionEndDate: json["subscription_end_date"] == null ? 'null' : json["subscription_end_date"],
//         nameOnCreditCard: json["name_on_credit_card"] == null ? 'null' : json["name_on_credit_card"],
//         creditCardNo: json["credit_card_no"] == null ? 'null' : json["credit_card_no"],
//         creditCardExpiry: json["credit_card_expiry"] == null ? 'null' : json["credit_card_expiry"],
//         creditCardCvc: json["credit_card_cvc"] == null ? 'null' : json["credit_card_cvc"],
//         zipcode: json["zipcode"] == null ? 'null' : json["zipcode"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "user_id": userId == null ? null : userId,
//         "user_display_name": userDisplayName == null ? null : userDisplayName,
//         "user_name": userName == null ? null : userName,
//         "user_email": userEmail == null ? null : userEmail,
//         "user_phone": userPhone == null ? null : userPhone,
//         "user_address": userAddress == null ? null : userAddress,
//         "user_dob": userDob == null ? null : userDob,
//         "user_profile_picture": userProfilePicture == null ? null : userProfilePicture,
//         "user_registered_on": userRegisteredOn == null ? null : userRegisteredOn.toIso8601String(),
//         "premium_status": premiumStatus == null ? null : premiumStatus,
//         "auto_payments": autoPayments == null ? null : autoPayments,
//         "subscription_end_date": subscriptionEndDate == null ? null : subscriptionEndDate,
//         "name_on_credit_card": nameOnCreditCard == null ? null : nameOnCreditCard,
//         "credit_card_no": creditCardNo == null ? null : creditCardNo,
//         "credit_card_expiry": creditCardExpiry == null ? null : creditCardExpiry,
//         "credit_card_cvc": creditCardCvc == null ? null : creditCardCvc,
//         "zipcode": zipcode == null ? null : zipcode,
//       };
// }


// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
  int? userId;
  String? userDisplayName;
  String? userName;
  String? userEmail;
  dynamic userPhone;
  dynamic userAddress;
  dynamic userDob;
  dynamic userProfilePicture;
  DateTime? userRegisteredOn;
  dynamic premiumStatus;
  dynamic autoPayments;
  dynamic subscriptionEndDate;
  dynamic nameOnCreditCard;
  dynamic creditCardNo;
  dynamic creditCardExpiry;
  dynamic creditCardCvc;

  UserDetailsModel({
    this.userId,
    this.userDisplayName,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userAddress,
    this.userDob,
    this.userProfilePicture,
    this.userRegisteredOn,
    this.premiumStatus,
    this.autoPayments,
    this.subscriptionEndDate,
    this.nameOnCreditCard,
    this.creditCardNo,
    this.creditCardExpiry,
    this.creditCardCvc,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
    userId: json["user_id"],
    userDisplayName: json["user_display_name"],
    userName: json["user_name"],
    userEmail: json["user_email"],
    userPhone: json["user_phone"],
    userAddress: json["user_address"],
    userDob: json["user_dob"],
    userProfilePicture: json["user_profile_picture"],
    userRegisteredOn: json["user_registered_on"] == null ? null : DateTime.parse(json["user_registered_on"]),
    premiumStatus: json["premium_status"],
    autoPayments: json["auto_payments"],
    subscriptionEndDate: json["subscription_end_date"],
    nameOnCreditCard: json["name_on_credit_card"],
    creditCardNo: json["credit_card_no"],
    creditCardExpiry: json["credit_card_expiry"],
    creditCardCvc: json["credit_card_cvc"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_display_name": userDisplayName,
    "user_name": userName,
    "user_email": userEmail,
    "user_phone": userPhone,
    "user_address": userAddress,
    "user_dob": userDob,
    "user_profile_picture": userProfilePicture,
    "user_registered_on": userRegisteredOn?.toIso8601String(),
    "premium_status": premiumStatus,
    "auto_payments": autoPayments,
    "subscription_end_date": subscriptionEndDate,
    "name_on_credit_card": nameOnCreditCard,
    "credit_card_no": creditCardNo,
    "credit_card_expiry": creditCardExpiry,
    "credit_card_cvc": creditCardCvc,
  };
}
