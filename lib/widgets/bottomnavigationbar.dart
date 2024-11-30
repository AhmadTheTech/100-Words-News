import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/bookmark.dart';
import 'package:news_app/screens/category.dart';
import 'package:news_app/screens/home.dart';

import '../screens/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  List<Widget> tabItems = [
    const HomePage(),
    const CategoriesScreen(),
    const BookMarkedVideosPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabItems[_selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        backgroundColor: Theme.of(context).colorScheme.surface,
        iconSize: 30,
        showElevation: false,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
            ),
            title: Text(
              'گھر',
              style: GoogleFonts.notoSansArabic(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              ),
            ), // Home
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.category ,color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),),
            title: Text(
              'دریافت',
              style: GoogleFonts.notoSansArabic(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),              ),
            ), // Category
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.bookmark ,color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),),
            title: Text(
              'بک مارک',
              style: GoogleFonts.notoSansArabic(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              ),
            ), //Bookmark
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person ,color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),),
            title: Text(
              'پروفائل',
              style: GoogleFonts.notoSansArabic(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              ),
            ), // Profile
          ),
        ],
      ),
    );
  }
}
