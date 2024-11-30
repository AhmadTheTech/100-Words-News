import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/extra/extra.dart';
import '../widgets/allwidgets.dart';
import '../widgets/bottomnavigationbar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));
  }
  void forgotPassword() {
    Loader().start(controller, context);
    Future.delayed(const Duration(seconds: 7)).whenComplete(() {
      Loader().end(context);
     Navigation().navigationHelper(context, const BottomNav());
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: height * 0.48,
                  child: Lottie.asset(AppExtras.forgotPassword)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Form(
                        child: Column(
                          children: [
                            InputFields(
                              isPass: false,
                              title: 'ای میل',
                              icon: Icons.mail,
                              borderRadius: 13,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ButtonWidget(
                              color: Colors.blue,
                              title: "ری سیٹ کریں",
                              borderRadius: 13,
                              textColor: Colors.white,
                              borderColor: Colors.blue,
                              onTap: forgotPassword,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "کیا آپ کو پاس ورڈ معلوم ہے؟",
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansArabic(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: () {
               Navigator.pop(context);
              },
              child: Text(
                "لاگ ان کریں",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansArabic(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
