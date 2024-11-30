import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/categories.dart';
import 'package:news_app/widgets/category-card.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import '../widgets/allwidgets.dart';
import 'package:http/http.dart' as http;

import '../widgets/headlinecard.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
   CategoryData? categoryData;
  bool isLoading = true;
  final List<Map<String, dynamic>> list = [
    {
      'title': 'مالیاتی خبریں', // Finance News
    },
    {
      'title': 'تعلیمی خبریں', // Education News
    },
    {
      'title': 'صحت کی خبریں', // Health News
    },
    {
      'title': 'سائنس اور ٹیکنالوجی', // Science and Technology
    },
    {
      'title': 'تفریحی خبریں', // Entertainment News
    },
    {
      'title': 'کھیل کی خبریں', // Sports News
    },
    {
      'title': 'سیاست', // Politics
    },
    {
      'title': 'معاشی تجزیہ', // Economic Analysis
    },
    {
      'title': 'ماحولیاتی خبریں', // Environment News
    },
    {
      'title': 'کاروباری خبریں', // Business News
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "مختلف موضوعات کی خبریں",
          style: GoogleFonts.notoSansArabic(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? Shimmer.fromColors(
              baseColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.grey[300]!,
              highlightColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[700]!
                  : Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 150,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                          ),
                        );
                      }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    ),
                  ],
                ),
              ),
            )
          : GridView.builder(
              itemCount: categoryData!.categoriesPage.length,
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final category = categoryData!.categoriesPage[index];
                return CategoryCardWidget(
                  title: category.categoryTitle,
                  image: category.largeCategoriesImage,
                  onTap: () {
                    Navigation().navigationHelper(
                        context,
                        CategoriesDetailPage(
                          categoryPageTitle: category.categoryTitle, newsData: category.videos,
                        ));
                  },
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            ),
    );
  }

  Future<void> getCategoryData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://devsline.tech/cut-the-fat/wp-json/page/v2/cat_ctf'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print('Response data: $data');
        }
        if (mounted) {
          setState(() {
            categoryData = CategoryData.fromJson(data);
            isLoading = false;
          });
        }
      } else {
        if (kDebugMode) {
          print('Failed to load data. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception occurred: $e');
      }
    }
  }
}

class CategoriesDetailPage extends StatefulWidget {
  final List<Video> newsData;
  final String categoryPageTitle;
  const CategoriesDetailPage(
      {super.key, required this.newsData, this.testingController, required this.categoryPageTitle});
  final Controller? testingController;

  @override
  State<CategoriesDetailPage> createState() => _CategoriesDetailPageState();
}

class _CategoriesDetailPageState extends State<CategoriesDetailPage> {
  late Controller controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = widget.testingController ?? Controller()
      ..addListener((event) {
        _handleCallbackEvent(event);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: Text(
          widget.categoryPageTitle,
          style: GoogleFonts.notoSansArabic(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: TikTokStyleFullPageScroller(
        contentSize: widget.newsData.length,
        controller: controller,
        builder: (context, index) {
          final newsItem = widget.newsData[index];
          return Column(
            children: [
              NewsCard(
                title: newsItem.title,
                image: newsItem.videoImage,
                description: newsItem.subTitle,
                uniqueId: newsItem.uniqueId,
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleCallbackEvent(ScrollEvent event) {
    if (kDebugMode) {
      print(
          "Scroll callback received with data: {direction: ${event.direction}, success: ${event.success} and page: ${event.pageNo ?? 'not given'}}");
    }
    if (event.percentWhenReleased != null) {
      if (kDebugMode) {
        print("Percent when released: ${event.percentWhenReleased}");
      }
    }
  }
}
