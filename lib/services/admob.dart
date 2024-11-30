// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class AdMobServices {
//   static String? get bannerAdUnitId {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-39402560999425444/6300978111';
//     } else if (Platform.isIOS) {
//       return 'ca-app-pub-39402560999425444/6300978111';
//     }
//     return null;
//   }
//
//   static String? get interstitialAdUnit {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-39402560999425444/1033173712';
//     } else if (Platform.isIOS) {
//       return 'ca-app-pub-39402560999425444/1033173712';
//     }
//     return null;
//   }
//
//   static final BannerAdListener bannerAdListener = BannerAdListener(
//     onAdLoaded: (ad) {
//       debugPrint('Ad Loaded');
//     },
//     onAdFailedToLoad: (ad, error) {
//       ad.dispose();
//       debugPrint('Ad Failed To Load: $error');
//     },
//     onAdOpened: (ad) {
//       debugPrint('Ad Opened');
//     },
//     onAdClosed: (ad) {
//       debugPrint('Ad Closed');
//     },
//   );
// }
