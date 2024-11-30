import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/auth/forgot-pass.dart';
import 'package:news_app/auth/signup.dart';
import 'package:news_app/extra/extra.dart';
import 'package:news_app/models/apiClient.dart';
import 'package:news_app/models/user_DetailsModel.dart';
import 'package:wp_json_api/enums/wp_auth_type.dart';
import 'package:wp_json_api/models/responses/wp_user_login_response.dart';
import 'package:wp_json_api/wp_json_api.dart';
import 'package:news_app/widgets/allwidgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  bool passwordVisible = false;
  late ThemeData themeData;
  FocusNode passFocus = FocusNode();
  FocusNode mailFocus = FocusNode();
  bool mailColor = false;
  bool passColor = false;
  bool showSpass = false;
  bool showMail = false;
  bool showPassword = false;

  var emailController = TextEditingController();
  var passController = TextEditingController();

  bool validation(BuildContext context) {
    bool isValid = true;
    var username = emailController.text;
    var password = passController.text;

    if (username.isEmpty) {
      isValid = false;
      if (kDebugMode) {
        print("براہ کرم اپنی ای میل درج کریں");
      }
      toastWidget(
        context,
        "خطا",
        "براہ کرم اپنی ای میل درج کریں",
        true,
      );
    }else if (username.length < 6) {
      isValid = false;
      if (kDebugMode) {
        print("براہ کرم اپنی ای میل درج کریں");
      }
      toastWidget(
        context,
        "خطا",
        "براہ کرم درست ای میل استعمال کریں",
        true,
      );
    }else if (password.isEmpty) {
      isValid = false;
      toastWidget(
        context,
        "خطا",
        "براہ کرم اپنی پاس ورڈ درج کریں",
        true,
      );
    } else if (password.length < 6) {
      isValid = false;
      toastWidget(
        context,
        "خطا",
        "براہ کرم درست پاس ورڈ استعمال کریں",
        true,
      );
    }

    return isValid;
  }


  login() async {
    // EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.wave;
    // EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    // EasyLoading.instance.indicatorSize = 35.0;
    // EasyLoading.instance.radius = 7.0;
    // EasyLoading.instance.progressColor = Colors.white;
    // EasyLoading.instance.backgroundColor = Colors.grey;
    // EasyLoading.instance.indicatorColor = Colors.white;
    // EasyLoading.instance.textColor = Colors.white;
    try {
      if (validation(context)) {
        Loader().start(controller, context);

        String email = emailController.text;
        String password = passController.text;

        WPUserLoginResponse? wpUserLoginResponse;
        print(email + password);
        wpUserLoginResponse = await WPJsonAPI.instance.api((request) =>
            request.wpLogin(
                email: email,
                password: password,
                authType: WPAuthType.WpEmail,
                saveTokenToLocalStorage: false));

        print(wpUserLoginResponse?.status);
        if (wpUserLoginResponse?.status == 200) {
          String? userToken = wpUserLoginResponse?.data!.userToken;
          mUserToken = userToken!;
          print(wpUserLoginResponse!.data!.userId.toString());
          UserDetailsModel userdetails = await ApiClient.apiClient
              .GetUserDetails(wpUserLoginResponse.data!.userId.toString());
          // TrailModel userTrailDetails = await ApiClient.apiClient.GetUserTrialDetails(wpUserLoginResponse.data!.userId.toString());
          Loader().end(context);
          setSession(context, userdetails, userToken);
          toastWidget(
            context,
            'Login Successfull',
            'آپ لاگ ان ہو گئے ہیں',
            true,
          );
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          print('done');
        } else {
          toastWidget(
            context,
            'Login failed',
            'غلط ای میل یا پاس ورڈ ہے',
            true,
          );
          Loader().end(context);
        }
      }
    } catch (e) {
      toastWidget(
        context,
        "Login Failed",
        "غلط ای میل یا پاس ورڈ ہے",
        true,
      );
      Loader().end(context);

      if (kDebugMode) {
        print("Added error $e");
      }
    }
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
                  child: Lottie.asset(AppExtras.login)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Form(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InputFields(
                          isPass: false,
                          title: 'ای میل',
                          icon: Icons.mail,
                          borderRadius: 13,
                          controller: emailController,
                          onChanged: (value) {
                            if (kDebugMode) {
                              print(value);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InputFields(
                          title: 'پاسورڈ',
                          icon: Icons.lock,
                          borderRadius: 13,
                          isPass: true,
                          controller: passController,
                          onChanged: (value) {
                            if (kDebugMode) {
                              print(value);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: GestureDetector(
                            onTap: () {
                              Navigation().navigationHelper(
                                  context, const ForgotPassword());
                            },
                            child: Text(
                              "پاسورڈ بھول گئے",
                              style: GoogleFonts.notoSansArabic(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ButtonWidget(
                          color: Colors.blue,
                          title: 'لاگ ان کریں',
                          borderRadius: 13,
                          textColor: Colors.white,
                          borderColor: Colors.blue,
                          onTap: () {
                            login();
                            if (kDebugMode) {
                              print('Button Is Pressed');
                            }
                          },
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
              "کیا آپ کے پاس اکاؤنٹ نہیں ہے؟",
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
                Navigation().navigationHelper(context, const SignUpPage());
              },
              child: Text(
                "سائن اپ کریں",
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
