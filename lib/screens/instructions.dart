import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/extra/extra.dart';
import 'package:news_app/screens/home.dart';
import '../widgets/allwidgets.dart';
import '../widgets/bottomnavigationbar.dart';

class InstructionsPage extends StatefulWidget {
  const InstructionsPage({super.key});

  @override
  State<InstructionsPage> createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> with TickerProviderStateMixin{
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
  }
  void letsStart() {
    Loader().start(controller, context);
    Future.delayed(const Duration(seconds: 7)).whenComplete(() {
      Loader().end(context);
      Navigation().navigationHelper(context, const BottomNav());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "جلدی خبریں",
          style: GoogleFonts.notoSansArabic(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                AppExtras.swipeUp,
                width: 400,
                height: 400,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'مزید دیکھنے کے لیے اوپر سوائپ کریں۔',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansArabic(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'یہ صفحہ آپ کو مزید خبریں دیکھنے کی ہدایات دیتا ہے۔ اوپر سوائپ کرکے آپ تازہ ترین خبریں دیکھ سکتے ہیں۔',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansArabic(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                color: Colors.blue,
                title: 'ابھی شامل ہوں',
                borderRadius: 13,
                textColor: Colors.white,
                borderColor: Colors.blue,
                onTap: letsStart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
