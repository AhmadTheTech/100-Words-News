import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/reset.dart';
import 'package:news_app/models/signupUpdateUser.dart';
import 'package:wp_json_api/models/responses/wp_nonce_response.dart';
import 'package:wp_json_api/models/responses/wp_nonce_verified_response.dart';
import 'package:wp_json_api/models/responses/wp_user_register_response.dart';
import 'package:wp_json_api/wp_json_api.dart';
import 'package:news_app/models/updatePassModel.dart';
import 'package:news_app/models/user_DetailsModel.dart';
import 'package:news_app/services/sharedPrefs.dart';

import '../widgets/allwidgets.dart';

class ApiClient {
  ApiClient._();

  static final ApiClient apiClient = ApiClient._();

  static final http.Client _httpClient = http.Client();

  final baseURL = "https://nexmart.great-site.net/wp-json";

  Future<String?> GetNounce() async {
    try {
      WPNonceResponse wpNonceResponse =
          await WPJsonAPI.instance.api((request) => request.wpNonce());

      WPNonceVerifiedResponse wpNonceVerifiedResponse = await WPJsonAPI.instance
          .api((request) =>
              request.wpNonceVerify(nonce: wpNonceResponse.data?.nonce ?? ""));

      if (wpNonceVerifiedResponse.data?.isValid ?? false) {
        return wpNonceResponse.data?.nonce;
      } else {
        return "";
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error("Server Error");
    }
  }

  SendResetEmail(String email) async {
    try {
      var headers = {
        'Authorization':
            'Basic Y2tfOWU4MWExZWUzNTcyMTU4YjQyMDE3NmNlNmI3NDdmZTQ1NDU3NDUyMTpjc18zMTkxY2VmNWU4Nzc4YWQyMzg0YWRhYTJhMTJhMmQ0MThkNjRlNWNi'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://nexmart.great-site.net/wp-json/get/v2/resetpassword'));
      request.fields.addAll({'user_login': email});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String res = await response.stream.bytesToString();
        print(res);

        final parsed = json.decode(res);
        return MessageResponse.fromJson(parsed);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      print("DeleteMyBooking $e");
      return Future.error("Server Error");
    }
  }

  SendUpdatePassRequestFromApp(
      String userid, String oldpass, String newpass) async {
    try {
      var headers = {
        'Authorization':
            'Basic Y2tfOWU4MWExZWUzNTcyMTU4YjQyMDE3NmNlNmI3NDdmZTQ1NDU3NDUyMTpjc18zMTkxY2VmNWU4Nzc4YWQyMzg0YWRhYTJhMTJhMmQ0MThkNjRlNWNi'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('https://nexmart.great-site.net/wp-json/get/v2/updatepass'));
      request.fields.addAll(
          {'user_id': userid, 'password': oldpass, 'new_password': newpass});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String res = await response.stream.bytesToString();
        print(res);

        final parsed = json.decode(res);
        return UpdatePassFromApp.fromJson(parsed);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      print("DeleteMyBooking " + e.toString());
      return Future.error("Server Error");
    }
  }

  Future<WPUserRegisterResponse> RegisterUser(
      String username, String email, String password) async {
    try {
      WPUserRegisterResponse wpUserRegisterResponse = await WPJsonAPI.instance
          .api((request) => request.wpRegister(
              email: email,
              password: password,
              username: email,
              saveTokenToLocalStorage: false));
      return wpUserRegisterResponse;
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error("Server Error");
    }
  }

  //
  updatePinfo(
      String userId,
      String ccname,
      String cardNo,
      String cvcNo,
      String expMonth,
      String expYear,
      String premiumstatus,
      String subenddate,
      String autopayments,
      String zipcode) async {
    try {
      print(subenddate);
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://nexmart.great-site.net/wp-json/update/user/payment/infoo'));
      request.fields.addAll({
        'user_id': userId,
        'premium_status': premiumstatus,
        'name_on_cc': ccname,
        'cc_no': cardNo,
        'cc_exp': "$expMonth/$expYear",
        'cc_cvc': cvcNo,
        'sub_end_date': subenddate,
        'auto_payments': autopayments,
        'zipcode': zipcode,
      });

      print(request.fields);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String res = await response.stream.bytesToString();
        print(res);
        final parsed = json.decode(res);
        return SignupUpdateUserDetailsResult.fromJson(parsed);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

  //
  // UpdateUsedCoupon(String userid, String coupon) async {
  //   try {
  //     var request = http.MultipartRequest('POST', Uri.parse('https://nexmart.great-site.net/wp-json/add/usedcoupons'));
  //     request.fields.addAll({'userid': userid, 'coupon': coupon});
  //
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       String res = await response.stream.bytesToString();
  //       print(res);
  //       final parsed = json.decode(res);
  //       return SignupUpdateUserDetailsResult.fromJson(parsed);
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } on SocketException {
  //     return Future.error("check your internet connection");
  //   } on http.ClientException {
  //     return Future.error("check your internet connection");
  //   } catch (e) {
  //     return Future.error("Server Error");
  //   }
  // }
  //
//
  // GetCoupons() async {
  //   try {
  //     final response = await _httpClient.get(Uri.parse('https://nexmart.great-site.net/wp-json/get/coupons/'));
  //     print("Get Meals Response " + response.body);
  //     return couponsFromJson(response.body);
  //   } on SocketException {
  //     return Future.error("Check Your Internet Connection");
  //   } on http.ClientException {
  //     return Future.error("Check Your Internet Connection");
  //   } catch (e) {
  //     print("Get Coupons" + e.toString());
  //     return Future.error("Server Error");
  //   }
  // }
  //
  // // Future<UserRegisterModelRes> RegisterUser(
  // //     String username, String email, String password) async {
  // //   try {
  // //     var request = http.MultipartRequest(
  // //         'POST',
  // //         Uri.parse(
  // //             'https://devsline.tech/asia/?wpwhpro_api_key=ekclxm1hymxrpsrvzmg9g1ur13ivta85dh3jnhw7n2odo7ac3l2j2ei4ss55nbuz&wpwhpro_action=registeruserbyapp&action=create_user'));
  // //     request.fields.addAll({
  // //       'user_email': email,
  // //       'user_pass': password,
  // //       'username': email,
  // //       'display_name': username,
  // //     });
  // //
  // //     http.StreamedResponse response = await request.send();
  // //
  // //     if (response.statusCode == 200) {
  // //       String res = await response.stream.bytesToString();
  // //       print(res);
  // //       final parsed = json.decode(res);
  // //       return UserRegisterModelRes.fromJson(parsed);
  // //     } else {
  // //       print(response.reasonPhrase);
  // //     }
  // //   } on SocketException {
  // //     return Future.error("Check Your Internet Connection");
  // //   } on http.ClientException {
  // //     return Future.error("Check Your Internet Connection");
  // //   } catch (e) {
  // //     return Future.error("Server Error");
  // //   }
  // // }
  // //
  // // UserRegisterModelRes userRegisterModelResFromJson(String str) =>
  // //     UserRegisterModelRes.fromJson(json.decode(str));
  // SendResetEmail(String email) async {
  //   try {
  //     var headers = {'Authorization': 'Basic Y2tfOWU4MWExZWUzNTcyMTU4YjQyMDE3NmNlNmI3NDdmZTQ1NDU3NDUyMTpjc18zMTkxY2VmNWU4Nzc4YWQyMzg0YWRhYTJhMTJhMmQ0MThkNjRlNWNi'};
  //     var request = http.MultipartRequest('POST', Uri.parse('https://nexmart.great-site.net/wp-json/get/v2/resetpassword'));
  //     request.fields.addAll({'user_login': email});
  //
  //     request.headers.addAll(headers);
  //
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       String res = await response.stream.bytesToString();
  //       print(res);
  //
  //       final parsed = json.decode(res);
  //       return MessageResponse.fromJson(parsed);
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } on SocketException {
  //     return Future.error("check your internet connection");
  //   } on http.ClientException {
  //     return Future.error("check your internet connection");
  //   } catch (e) {
  //     print("DeleteMyBooking $e");
  //     return Future.error("Server Error");
  //   }
  // }
  //
  // Future<WPUserLoginResponse> LoginUser(String username, String password) async {
  //   try {
  //     WPUserLoginResponse wpUserLoginResponse = await WPJsonAPI.instance.api((request) => request.wpLogin(username: username, password: password, authType: WPAuthType.WpEmail));
  //     return wpUserLoginResponse;
  //   } on SocketException {
  //     return Future.error("check your internet connection");
  //   } on http.ClientException {
  //     return Future.error("check your internet connection");
  //   } catch (e) {
  //     print(e.toString());
  //     return Future.error("Server Error");
  //   }
  // }
  //
  UpdateUserDetailsWithPicture(String userid, String phone, String address,
      String dob, int premium, int autopayment, File picture) async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse('https://nexmart.great-site.net/wp-json/update/user/infoo'));
      request.fields.addAll({
        'user_id': userid,
        'phone': phone,
        'address': address,
        'dob': dob,
        'premium_status': premium.toString(),
        'auto_payments': autopayment.toString()
      });

      if (picture == null) {
      } else {
        request.files.add(
            await http.MultipartFile.fromPath('profilepicture', picture.path));
      }

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String res = await response.stream.bytesToString();
        print(res);

        final parsed = json.decode(res);
        return SignupUpdateUserDetailsResult.fromJson(parsed);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Reset Request $e");
      return Future.error("Server Error");
    }
  }

  Future<UserDetailsModel> GetUserDetails(String userid) async {
    print("Request === " +
        "https://nexmart.great-site.net/wp-json/get/user/infoo?user_id=$userid");
    try {
      final response = await _httpClient.get(Uri.parse(
          'https://nexmart.great-site.net/wp-json/get/user/infoo?user_id=$userid'));
      print("Get User Details ${response.body}");
      return parseUserDetails(response.body);
    } catch (e) {
      print("Get Details$e");
      return Future.error("Server Error");
    }
  }

  Future<http.Response> getUserSubStatus() async {
    print("Request === " +
        "https://nexmart.great-site.net/wp-json/page/v2/bts_appapprove_jamal");
    try {
      final response = await _httpClient.get(Uri.parse(
          'https://nexmart.great-site.net/wp-json/page/v2/bts_appapprove_jamal'));
      print("Get User Sub Details ${response.body}");
      //   return parseUserDetails(response.body);
      return response;
    } catch (e) {
      print("Get Details$e");
      return Future.error("Server Error");
    }
  }

  // Future<TrailModel> GetUserTrialDetails(String userid) async {
  //   try {
  //     final response = await _httpClient.get(Uri.parse('https://nexmart.great-site.net/wp-json/get/user/trail-infoo?user_id=$userid'));
  //     print("Get User Trail Details ${response.body}");
  //     return trailModelFromJson(response.body);
  //   } catch (e) {
  //     print("Get Trail Details" + e.toString());
  //     return Future.error("Server Error");
  //   }
  // }
  //
  UserDetailsModel parseUserDetails(String str) =>
      UserDetailsModel.fromJson(json.decode(str));

  Future<void> UpdateUserDetails(String userid, String phone, String address,
      String dob, int premiumstatus, int autopayment, String subendDate) async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse('https://nexmart.great-site.net/wp-json/update/user/infoo'));
      request.fields.addAll({
        'user_id': userid,
        'phone': phone,
        'address': address,
        'dob': dob,
        'premium_status': premiumstatus.toString(),
        'sub_end_date': subendDate,
        'auto_payments': autopayment.toString(),
      });
      print("============ Payload ================");
      print(request.fields);
      print("============ Payload End ============");
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print(responseBody);
      } else {
        print(response.reasonPhrase);
      }
    } on http.ClientException catch (e) {
      print("UpdateUserDetails Request failed: $e");
      // Re-throw a more specific error message
      throw Exception('Error updating user details: ${e.message}');
    } catch (e) {
      // Catch other unexpected errors
      print("UpdateUserDetails Request failed: $e");
      throw Exception('Unknown error updating user details');
    }
  }

  Future<SignupUpdateUserDetailsResult> deleteUserAccount(
    String userId,
  ) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://nexmart.great-site.net/wp-json/delete/user'));
      request.fields.addAll({'user_id': userId});
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String res = await response.stream.bytesToString();
        final parsed = json.decode(res);
        return SignupUpdateUserDetailsResult.fromJson(parsed);
      } else {
        print(response.reasonPhrase);
        return Future.error("Not deleted User");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

  //
  // updateUserTrailDetails(
  //   String userId,
  //   String isTrailActive,
  //   String isTrailUsed,
  //   String trailStartDate,
  //   String trailEndDate,
  // ) async {
  //   try {
  //     var request = http.MultipartRequest(
  //         'GET',
  //         Uri.parse(
  //             'https://nexmart.great-site.net/wp-json/update/user/trail-infoo?user_id=$userId&trail_active=$isTrailActive&trail_already_use=$isTrailUsed&trail_startdate=$trailStartDate&trail_enddate=$trailEndDate'));
  //
  //     http.StreamedResponse response = await request.send();
  //     if (response.statusCode == 200) {
  //       String res = await response.stream.bytesToString();
  //       print(res);
  //       final parsed = json.decode(res);
  //       return SignupUpdateUserDetailsResult.fromJson(parsed);
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } on SocketException {
  //     return Future.error("check your internet connection");
  //   } on http.ClientException {
  //     return Future.error("check your internet connection");
  //   } catch (e) {
  //     return Future.error("Server Error");
  //   }
  // }

  setSession(
      BuildContext context, UserDetailsModel userdetailmodel, String token) {
    SharedPrefManager.setUserId(userdetailmodel.userId.toString());
    SharedPrefManager.setUserName(userdetailmodel.userDisplayName);
    SharedPrefManager.setUserEmail(userdetailmodel.userEmail);
    SharedPrefManager.setUserJoinedDate(
        userdetailmodel.userRegisteredOn.toString());
    SharedPrefManager.setUserImage(
        userdetailmodel.userProfilePicture.toString());
    SharedPrefManager.setLoginSession(true);
    SharedPrefManager.setToken(token);
    SharedPrefManager.setUserAutoPayments(userdetailmodel.autoPayments);
    SharedPrefManager.setUserPremiumStatus(userdetailmodel.premiumStatus);
    SharedPrefManager.setUserSubScriptionEndDate(
        userdetailmodel.subscriptionEndDate);
    SharedPrefManager.setUserDob(userdetailmodel.userDob);
    SharedPrefManager.setUserAddress(userdetailmodel.userAddress);
    SharedPrefManager.setUserPhone(userdetailmodel.userPhone);
    // SharedPrefManager.setUserTrailAlreadyUsed(usertraildetails.alreadyUsed == null ? true : usertraildetails.alreadyUsed);
    // SharedPrefManager.setUserTrailStatus(usertraildetails.isTrialActive == null ? false : usertraildetails.isTrialActive);
    // SharedPrefManager.setUserTrailStartDate(userdetailmodel.userRegisteredOn.toString());
    // SharedPrefManager.setUserTrailEndDate(usertraildetails.trailEndDate == null ? "2022-07-03 09:51:23" : usertraildetails.trailEndDate.toString());

    mUserID = userdetailmodel.userId.toString();
    mUserDisplayName = userdetailmodel.userDisplayName ?? "null";
    mEmail = userdetailmodel.userEmail ?? "null";
    mUserJoinedDate = userdetailmodel.userRegisteredOn.toString();
    mUserImage = userdetailmodel.userProfilePicture;
    mUserAutoPayments = userdetailmodel.autoPayments;
    mUserPremiumStatus = userdetailmodel.premiumStatus;
    mUserSubscriptionEndDate = userdetailmodel.subscriptionEndDate;
    mUserPhone = userdetailmodel.userPhone;
    mUserAddress = userdetailmodel.userAddress;
    mUserDob = userdetailmodel.userDob;
    isLoggedIn = true;
    // isTrailActive = usertraildetails.isTrialActive == null ? false : usertraildetails.isTrialActive;
    // trailAlreadyUsed = usertraildetails.alreadyUsed == null ? false : usertraildetails.alreadyUsed;
    // mUserTrialEndDate = usertraildetails.trailEndDate == null || usertraildetails.trailEndDate.toString().isEmpty ? DateTime.parse("2022-07-03 09:51:23") : usertraildetails.trailEndDate!;
    mUserTrialStartDate = userdetailmodel.userRegisteredOn!;

    // !userdetailmodel.premiumStatus && usertraildetails.alreadyUsed ?

    //isTrailActive || mUserPremiumStatus ?
    // navigateToReplace(context, HomePage()) ;
    //    :
    // navigateToReplace(context, TrailPayment())
    //: navigateToReplace(context, HomePage()) ;
  }
}
