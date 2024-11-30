import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/extra/extra.dart';
import 'package:news_app/screens/instructions.dart';
import 'package:news_app/widgets/bottomnavigationbar.dart';
import '../widgets/allwidgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
  }

  void signup() {
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
                  height: height < 900 ?  height * 0.45 :  height * 0.48,
                  child: Lottie.asset(AppExtras.signUp)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Form(
                        child: Column(
                      children: [
                        const InputFields(
                          isPass: false,
                          title: 'نام',
                          icon: Icons.person,
                          borderRadius: 13,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const InputFields(
                          isPass: false,
                          title: 'ای میل',
                          icon: Icons.mail,
                          borderRadius: 13,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const InputFields(
                            title: 'پاسورڈ',
                            icon: Icons.lock,
                            borderRadius: 13,
                            isPass: true),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                            color: Colors.blue,
                            title: 'سائن اپ کریں',
                            borderRadius: 13,
                            textColor: Colors.white,
                            borderColor: Colors.blue,
                            onTap: signup)
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
              "کیا آپ کے پاس اکاؤنٹ ہے؟",
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
                Navigator.of(context).pop();
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
