import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/extra/extra.dart';
import 'package:news_app/models/apiClient.dart';
import 'package:news_app/models/signupUpdateUser.dart';
import 'package:news_app/screens/Wellcome.dart';
import 'package:news_app/services/sharedPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/allwidgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 60,
                  backgroundImage: AssetImage(AppExtras.profilePic),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  mUserDisplayName,
                  style: GoogleFonts.notoSansArabic(fontWeight: FontWeight.w900, fontSize: 20 ,color: Theme.of(context).colorScheme.secondary,),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(mEmail , style: GoogleFonts.notoSansArabic(
                  color: Theme.of(context).colorScheme.secondary,
                fontSize: 18
              ),)],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  List<String> titles = [
                    'اکاؤنٹ کی اپ ڈیٹ', // Account Update
                    'پاس ورڈ کی اپ ڈیٹ', // Password Update
                    'اکاؤنٹ حذف کریں', // Delete Account
                    'لاگ آؤٹ' // Logout
                  ];
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      Card(
                                           color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900]!: Colors.white,
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          leading: index == 0
                              ? Icon(Icons.person,color: Theme.of(context).colorScheme.secondary,)
                              : index == 1
                                  ?  Icon(Icons.privacy_tip_sharp,
                              color: Theme.of(context).colorScheme.secondary,)
                                  : index == 2
                                      ? const Icon(Icons.delete,
                            color: Colors.red,)
                                      : index == 3
                                          ? Icon(Icons.logout,
                            color: Theme.of(context).colorScheme.secondary,)
                                          : index == 4
                                              ? Icon(Icons.logout,
                            color: Theme.of(context).colorScheme.secondary,)
                                              : Icon(Icons.logout,
                            color: Theme.of(context).colorScheme.secondary,),
                          title: Text(
                            titles[index],
                            style: GoogleFonts.notoSansArabic(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          trailing:
                          Icon(Icons.arrow_forward_ios_outlined , color: Theme.of(context).colorScheme.secondary,),
                          onTap: () {
                            switch (index) {
                              case 0:
                                print("Account Update");
                                // Navigation().navigationHelper(
                                //     context, const AccountUpdateScreen());
                                break;
                              case 1:
                                print("Update Password");
                                // Navigator.pushNamed(context,
                                //     NavigationRoutes.passwordUpdateScreen);
                                break;
                              case 2:
                                print("Delete Account");
                                showDeleteAccountNotice(context);

                                break;
                              case 3:
                                print("Logout Account");
                                logout(context);
                                break;
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPrefManager.Token);
    await prefs.remove(SharedPrefManager.USER_NAME_F);
    await prefs.remove(SharedPrefManager.USER_EMAIL);
    await prefs.remove(SharedPrefManager.IS_LOGIN);
    await prefs.remove(SharedPrefManager.USER_PROFILE_IMAGE);
    await prefs.remove(SharedPrefManager.USER_JOINED_DATE);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    print("Preferences after logout: ${prefs.getKeys()}");
    toastWidget(
        context, 'لاگ آؤٹ کامیاب', 'آپ کا اکاؤنٹ لاگ آؤٹ ہو گیا ہے۔', true);
    // Navigator.popUntil(context, (route) => ProfileScreen());
  }

  void showDeleteAccountNotice(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text("اکاؤنٹ حذف کریں"),
              content: const Card(
                elevation: 0,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Text(
                      "کیا آپ واقعی اپنا اکاؤنٹ حذف کرنا چاہتے ہیں؟ ایسا کرنے سے ساری پچھلی ہسٹری صاف ہو جائے گی۔",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "منسوخ کریں",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    // deleteAccount(context);
                  },
                  child: const Text(
                    "ہاں، حذف کریں",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
              ],
            ));
  }

deleteAccount(BuildContext context) async {
    print(mUserID);
    SignupUpdateUserDetailsResult res =
    await ApiClient.apiClient.deleteUserAccount(mUserID);
    if (res.result) {
      toastWidget(context, "Account Deleted",
          "Your account has been successfully deleted.", true);
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigation().navigationHelper(context, const WelcomeScreen());
  }
}
