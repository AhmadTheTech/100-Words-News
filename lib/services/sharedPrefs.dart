import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static dynamic USER_ID = "user1.id";
  static dynamic USER_NAME_F = "user1.first";
  static dynamic Token = "token";
  static dynamic USER_EMAIL = "user1.email";
  static dynamic USER_JOINED_DATE = "user1.joindate";
  static dynamic IS_LOGIN = "user1.login";
  static dynamic USER_PROFILE_IMAGE = "user_image";

  static dynamic USER_PREMIUM_STATUS = "ups_status";
  static dynamic USER_AUTO_PAYMENTS = "ups_auto_p";
  static dynamic USER_SUBSCRIPTION_END_DATE = "user_sub_end_date";

  static dynamic USER_ADDRESS = "user_adddd";
  static dynamic USER_DOB = "user_ddoobb";
  static dynamic USER_PHONE = "user_phoneeee";

  static dynamic USER_TRAIL_ACTIVE = "USER_TRAIL_ACTIVE";
  static dynamic USER_TRAIL_START_DATE = "USER_TRAIL_START_DATE";
  static dynamic USER_TRAIL_END_DATE = "USER_TRAIL_END_DATE";
  static dynamic USER_FAVORITE_VIDEOS = "USER_FAVORITE_VIDEOS";
  static dynamic USER_TRAIL_ALREADY_USED = "USER_TRAIL_ALREADY_USED";

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static setUserId(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_ID, cookie);
  }

  static Future<dynamic> getUserId() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_ID) ?? "NA";
  }

  static setUserName(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_NAME_F, cookie);
  }

  static Future<dynamic> getUserName() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_NAME_F) ?? "NA";
  }

  static setToken(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Token, cookie);
  }

  static Future<dynamic> getToken() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(Token) ?? "NA";
  }

  static setUserEmail(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_EMAIL, cookie);
  }

  static Future<dynamic> getUserEmail() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_EMAIL) ?? "NA";
  }

  static setLoginSession(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_LOGIN, cookie);
  }

  static Future<dynamic> getLoginSession() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool(IS_LOGIN) ?? false;
  }

  static setUserJoinedDate(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_JOINED_DATE, cookie);
  }

  static Future<dynamic> getUserJoinedDate() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_JOINED_DATE) ?? "NA";
  }

  static setUserImage(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_PROFILE_IMAGE, cookie);
  }

  static Future<dynamic> getUserImage() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_PROFILE_IMAGE) ?? "NA";
  }

  static setUserPremiumStatus(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(USER_PREMIUM_STATUS, cookie);
  }

  static Future<dynamic> getUserPremiumStatus() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool(USER_PREMIUM_STATUS) ?? false;
  }

  static setUserAutoPayments(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(USER_AUTO_PAYMENTS, cookie);
  }

  static Future<dynamic> getUserAutoPayments() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool(USER_AUTO_PAYMENTS) ?? false;
  }

  static setUserSubScriptionEndDate(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_SUBSCRIPTION_END_DATE, cookie);
  }

  static Future<dynamic> getUserSubScriptionEndDate() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_SUBSCRIPTION_END_DATE) ?? "NA";
  }

  /////////////////

  static setUserAddress(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_ADDRESS, cookie);
  }

  static Future<dynamic> getUserAddress() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_ADDRESS) ?? "NA";
  }

  static setUserDob(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_DOB, cookie);
  }

  static Future<dynamic> getUserDob() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_DOB) ?? "NA";
  }

  static setUserPhone(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_PHONE, cookie);
  }

  static Future<dynamic> getUserPhone() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_PHONE) ?? "NA";
  }

  ////////////////
  static setUserTrailStartDate(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_TRAIL_START_DATE, cookie);
  }

  static Future<dynamic> getUserTrailStartDate() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_TRAIL_START_DATE) ?? "NA";
  }

  static setUserTrailEndDate(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_TRAIL_END_DATE, cookie);
  }

  static Future<dynamic> getUserTrailEndDate() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_TRAIL_END_DATE) ?? "NA";
  }

  static setUserTrailStatus(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(USER_TRAIL_ACTIVE, cookie);
  }

  static Future<dynamic> getUserTrailStatus() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool(USER_TRAIL_ACTIVE) ?? false;
  }

  static setUserTrailAlreadyUsed(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(USER_TRAIL_ALREADY_USED, cookie);
  }

  static Future<dynamic> getUserTrailAlreadyUsed() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool(USER_TRAIL_ALREADY_USED) ?? false;
  }





  static setUserFavorite(dynamic cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_FAVORITE_VIDEOS, cookie);
  }

  static Future<dynamic> getUserFavorite() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_FAVORITE_VIDEOS) ?? "NA";
  }



}
