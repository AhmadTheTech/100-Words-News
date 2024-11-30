import 'dart:ui';

import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:achievement_view/achievement_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:delightful_toast/delight_toast.dart';

import 'package:news_app/extra/extra.dart';
import 'package:news_app/widgets/bottomnavigationbar.dart';

import '../models/user_DetailsModel.dart';
import '../services/sharedPrefs.dart';

class ButtonWidget extends StatelessWidget {
  final Color color;
  final double borderRadius;
  final String title;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onTap;
  const ButtonWidget(
      {super.key,
      required this.color,
      required this.title,
      required this.borderRadius,
      required this.textColor,
      required this.borderColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.notoSansArabic(
                fontSize: 21, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }
}

class InputFields extends StatefulWidget {
  final String title;
  final IconData icon;
  final double borderRadius;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool isPass;
  const InputFields(
      {super.key,
      required this.title,
      required this.icon,
      required this.borderRadius,
      this.controller,
      required this.isPass,
      this.onChanged});

  @override
  State<InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  bool isObscure = true;
  void _togglePasswordVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).colorScheme.secondary,
      controller: widget.controller,
      obscureText: widget.isPass
          ? isObscure
              ? true
              : false
          : false,
      style: GoogleFonts.notoSansArabic(
          color: Theme.of(context).colorScheme.secondary),
      decoration: InputDecoration(
        suffixIcon: widget.isPass ? GestureDetector(
          onTap: (){
            _togglePasswordVisibility();
          },
            child: Icon(isObscure ? Icons.visibility :  Icons.visibility_off)) : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
        hintText: widget.title,
        hintStyle: GoogleFonts.notoSansArabic(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.secondary),
        fillColor: Colors.transparent,
        filled: true,
        prefixIcon: Icon(
          widget.icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary)),
      ),
      onChanged: widget.onChanged,
    );
  }
}

class Loader {
  Future<void> start(
      AnimationController controller, BuildContext context) async {
    controller.repeat();
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Lottie.asset(
          AppExtras.loader,
          animate: true,
          controller: controller,
          frameRate: const FrameRate(100),
        );
      },
    );
  }

  void end(BuildContext context) {
    Navigator.pop(context);
  }
}

class Navigation {
  Future<void> navigationHelper(BuildContext context, Widget pageName) async {
    await Navigator.push(
        context, CupertinoPageRoute(builder: (context) => pageName));
  }
}

class BuildErrorWidget {
  Widget buildErrorWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(image: AssetImage(AppExtras.errorImage)),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Text(
                'اندرونی سرور کی خرابی۔',
                style: GoogleFonts.notoSansArabic(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'ٹییم کو آگاہ کر دیا گیا ہے، اور ہم اس مسئلے کو جلد از جلد حل کرنے کے لیے کام کر رہے ہیں۔ براہ کرم تھوڑی دیر بعد دوبارہ کوشش کریں۔',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansArabic(
                    fontWeight: FontWeight.normal, fontSize: 19),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildNetworkErrorWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(image: AssetImage(AppExtras.internetErrorImage)),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Text(
                'انٹرنیٹ موجود نہیں ہے۔',
                style: GoogleFonts.notoSansArabic(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'آپ کا انٹرنیٹ کنکشن دستیاب نہیں ہے۔ براہ کرم اپنے کنکشن کی جانچ کریں اور یقینی بنائیں کہ آپ آن لائن ہیں، پھر دوبارہ کوشش کریں۔',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansArabic(
                    fontWeight: FontWeight.normal, fontSize: 19),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildNoDataErrorWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(image: AssetImage(AppExtras.noDataImage)),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Text(
                'اندرونی سرور کی خرابی۔',
                style: GoogleFonts.notoSansArabic(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'ٹییم کو آگاہ کر دیا گیا ہے، اور ہم اس مسئلے کو جلد از جلد حل کرنے کے لیے کام کر رہے ہیں۔ براہ کرم تھوڑی دیر بعد دوبارہ کوشش کریں۔',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansArabic(
                    fontWeight: FontWeight.normal, fontSize: 19),
              ),
            ],
          ),
        )
      ],
    );
  }
}

toastWidget(
  BuildContext context,
  String title,
  String msg,
  bool isCircle,
) {
  DelightToastBar(
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
    snackbarDuration: const Duration(seconds: 2),
    builder: (BuildContext context) {
      return ToastCard(
        title: Text(
          msg,
          style: GoogleFonts.notoSansArabic(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: const Icon(Icons.sentiment_satisfied_alt_outlined, size: 30),
      );
    },
  ).show(context);
}

bool isLoggedIn = false;
String mUserID = "";
String mUserToken = "";
String mUserDisplayName = "";
String mUserImage = "";
String mEmail = "";
String mUserJoinedDate = "";

bool mUserAutoPayments = false;
bool mUserPremiumStatus = false;
String mUserSubscriptionEndDate = '';
String mUserPhone = '';
String mUserAddress = '';
String mUserDob = '';

var mUserCreditCardNo = null;
var mUserCreditCardExpiry = null;

DateTime mUserTrialStartDate = DateTime.now();
DateTime mUserTrialEndDate = DateTime.now();
bool trailAlreadyUsed = false;
bool isTrailActive = false;

bool showPaymentPage = false;

// List<UpperBodyModel> allSearchVideos = [];
// List<UserFavModelPost> myFav = [];
bool loader = true;

setSession(
  BuildContext context,
  UserDetailsModel userdetailmodel,
  String token,
) {
  SharedPrefManager.setUserId(userdetailmodel.userId.toString());
  SharedPrefManager.setUserName(userdetailmodel.userDisplayName);
  SharedPrefManager.setUserEmail(userdetailmodel.userEmail);
  SharedPrefManager.setUserJoinedDate(
      userdetailmodel.userRegisteredOn.toString());
  SharedPrefManager.setUserImage(userdetailmodel.userProfilePicture.toString());
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
  mUserDisplayName = userdetailmodel.userDisplayName!;
  mEmail = userdetailmodel.userEmail!;
  mUserJoinedDate = userdetailmodel.userRegisteredOn.toString();
  mUserImage = userdetailmodel.userProfilePicture.toString();
  mUserAutoPayments = userdetailmodel.autoPayments;
  mUserPremiumStatus = userdetailmodel.premiumStatus;
  mUserSubscriptionEndDate = userdetailmodel.subscriptionEndDate == null
      ? "null"
      : userdetailmodel.subscriptionEndDate;
  mUserPhone = userdetailmodel.userPhone;
  mUserAddress = userdetailmodel.userAddress;
  mUserDob = userdetailmodel.userDob;
  mUserCreditCardNo = userdetailmodel.creditCardNo;
  mUserCreditCardExpiry = userdetailmodel.creditCardExpiry;
  isLoggedIn = true;
  // isTrailActive = usertraildetails.isTrialActive == null ? false : usertraildetails.isTrialActive;
  // trailAlreadyUsed = usertraildetails.alreadyUsed == null ? false : usertraildetails.alreadyUsed;
  // mUserTrialEndDate = usertraildetails.trailEndDate == null || usertraildetails.trailEndDate.toString().isEmpty ? DateTime.parse("2022-07-03 09:51:23") : usertraildetails.trailEndDate!;
  // mUserTrialStartDate = userdetailmodel.userRegisteredOn!;

  // !userdetailmodel.premiumStatus && usertraildetails.alreadyUsed ?

  // isTrailActive || mUserPremiumStatus ?
  // navigateToReplace(context, HomePage());
  //    :
  // navigateToReplace(context, TrailPayment())
  // :
  Navigation().navigationHelper(context, const BottomNav());
}
