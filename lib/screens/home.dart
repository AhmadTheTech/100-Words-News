import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/extra/extra.dart';
import 'package:news_app/models/newsapi.dart';
import 'package:news_app/widgets/headlinecard.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import '../widgets/allwidgets.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.testingController,
  });

  final Controller? testingController;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Controller controller;
  // NewsViewModel newsViewModel = NewsViewModel();
  bool isLoading = true;
  late final List<Headline> headlineData;
  final keyOne = GlobalKey();

  @override
  initState() {
    controller = widget.testingController ?? Controller()
      ..addListener((event) {
        _handleCallbackEvent(event);
      });
    super.initState();
    getHeadlineData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "جلدی خبریں",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      )
          : TikTokStyleFullPageScroller(
        contentSize: headlineData.length,
        controller: controller,
        builder: (context, index) {
          final newsItem = headlineData[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewsCard(
                title: newsItem.title,
                image: newsItem.acfFields.newsImage,
                description: newsItem.acfFields.newsDescription,
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

  Future<void> getHeadlineData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://nexmart.great-site.net/wp-json/page/v2/news_headlines'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print('Response data: $data');
        }

        if (mounted) {
          setState(() {
            headlineData = headlineFromJson(data);
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
