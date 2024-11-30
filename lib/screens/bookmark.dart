import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/extra/extra.dart';
import 'package:news_app/widgets/headlinecard.dart';
import 'package:news_app/widgets/news-card.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../widgets/allwidgets.dart';

class BookMarkedVideosPage extends StatefulWidget {
  const BookMarkedVideosPage({super.key});

  @override
  State<BookMarkedVideosPage> createState() => _BookMarkedVideosPageState();
}

class _BookMarkedVideosPageState extends State<BookMarkedVideosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "بک مارک شدہ",
          style: GoogleFonts.notoSansArabic(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey, blurRadius: 2, spreadRadius: 2)
                    ]),
                    child: SfDateRangePicker(
                      selectionMode: DateRangePickerSelectionMode.single,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      showNavigationArrow: true,
                      selectionShape: DateRangePickerSelectionShape.circle,
                      selectionColor: Theme.of(context).colorScheme.secondary,
                      selectionTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      rangeTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        todayTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      yearCellStyle: DateRangePickerYearCellStyle(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        todayTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      headerStyle: DateRangePickerHeaderStyle(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                        if (kDebugMode) {
                          print('Date selected: ${args.value}');
                        }
                        // Perform additional logic here
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigation().navigationHelper(
                                context,
                                BookMarkDetailPage(
                                  appBarTitle: AppExtras.demoBookmarkTitle,
                                  newsTitle: AppExtras.demoBookmarkTitle,
                                  newsDescription:
                                      AppExtras.demoBookmarkDescription,
                                  newsImage: AppExtras.demoBookmarkImage,
                                ));
                          },
                          child: BookmarkCard(
                              image: AppExtras.demoBookmarkImage,
                              title: AppExtras.demoBookmarkTitle,
                              description: AppExtras.demoBookmarkDescription)),
                      GestureDetector(
                          onTap: () {
                            Navigation().navigationHelper(
                                context,
                                BookMarkDetailPage(
                                  appBarTitle: AppExtras.demoBookmarkTitle,
                                  newsTitle: AppExtras.demoBookmarkTitle2,
                                  newsDescription:
                                      AppExtras.demoBookmarkDescription2,
                                  newsImage: AppExtras.demoBookmarkImage2,
                                ));
                          },
                          child: BookmarkCard(
                              image: AppExtras.demoBookmarkImage2,
                              title: AppExtras.demoBookmarkTitle2,
                              description: AppExtras.demoBookmarkDescription2)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookMarkDetailPage extends StatefulWidget {
  final String appBarTitle;
  final String newsTitle;
  final String newsDescription;
  final String newsImage;
  const BookMarkDetailPage(
      {super.key,
      required this.appBarTitle,
      required this.newsTitle,
      required this.newsDescription,
      required this.newsImage});

  @override
  State<BookMarkDetailPage> createState() => _BookMarkDetailPageState();
}

class _BookMarkDetailPageState extends State<BookMarkDetailPage> {
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
          widget.appBarTitle,
          style: GoogleFonts.notoSansArabic(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          NewsCard(
              title: widget.newsTitle,
              image: widget.newsImage,
              description: widget.newsDescription),
        ],
      ),
    );
  }
}
