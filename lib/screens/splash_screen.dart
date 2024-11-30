import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth/login.dart';
import 'package:news_app/extra/extra.dart';
import 'package:news_app/extra/supporting_elements.dart';
import 'package:news_app/screens/Wellcome.dart';
import 'package:news_app/widgets/allwidgets.dart';

import '../services/sharedPrefs.dart';
import '../widgets/bottomnavigationbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    performTimer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: AnimatedSplashScreen(
        backgroundColor: Theme.of(context).colorScheme.surface,
        splash: Image(
          image: AssetImage(AppExtras.appLogo)
        ).applyAnimation(color: Colors.white),
        centered: true,
        splashIconSize: 300,
        nextScreen: const BottomNav(),
        splashTransition: SplashTransition.sizeTransition,
        disableNavigation: true,
      ),
    );
  }

  setSession(BuildContext context) async {
    mUserID = await SharedPrefManager.getUserId();
    mUserDisplayName = await SharedPrefManager.getUserName();
    mEmail = await SharedPrefManager.getUserEmail();
    mUserImage = await SharedPrefManager.getUserImage();
    mUserAutoPayments = await SharedPrefManager.getUserAutoPayments();
    mUserPremiumStatus = await SharedPrefManager.getUserPremiumStatus();
    mUserSubscriptionEndDate =
    await SharedPrefManager.getUserSubScriptionEndDate();
    mUserToken = await SharedPrefManager.getToken();
    mUserPhone = await SharedPrefManager.getUserPhone();
    mUserAddress = await SharedPrefManager.getUserAddress();
    mUserDob = await SharedPrefManager.getUserDob();
    isLoggedIn = true;
    Navigation().navigationHelper(context, const BottomNav());
  }

  performTimer(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      SharedPrefManager.getLoginSession().then((value) {
        if (value) {
          setSession(context);
        } else {
          Navigation().navigationHelper(context, const WelcomeScreen());
        }
      });
    });
  }
}
