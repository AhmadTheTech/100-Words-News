import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/extra/extra.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/widgets/allwidgets.dart';

import '../auth/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                opacity: .6,
                image: AssetImage(AppExtras.background),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "تازہ ترین خبریں جاننے کے لیے باخبر رہیں",
                        style: GoogleFonts.notoSansArabic(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 06,
                      ),
                      Text(
                        "دنیا بھر سے بریکنگ نیوز سے باخبر رہیں۔ آپ کی انگلیوں پر ذاتی نوعیت کی خبریں!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSansArabic(
                            fontSize: 14, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ButtonWidget(
                          color: Colors.transparent,
                          title: 'لاگ ان کریں',
                          borderRadius: 20,
                          textColor: Colors.white,
                          borderColor: Colors.white,
                          onTap: () {
                           Navigation().navigationHelper(context, const LoginPage());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
