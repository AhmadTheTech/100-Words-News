import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsCard extends StatefulWidget {
  final String title;
  final String image;
  final String description;
  final String? uniqueId;
  const NewsCard(
      {super.key,
      required this.title,
      required this.image,
      required this.description, this.uniqueId});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  DateTime now = DateTime.now();
  bool isBookMarked = false;
  late String uniqueKey;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uniqueKey = widget.uniqueId ?? widget.title.hashCode.toString();
    _loadBookmarkStatus();
  }

  _loadBookmarkStatus() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      isBookMarked = pref.getBool(uniqueKey) ?? false;
    });
  }

  _saveBookMarkedStatus(bool value) async {
    final pref = await SharedPreferences.getInstance();
    List<String> bookmarkedNews = pref.getStringList('bookmarkedNews') ?? [];

    String newsData = jsonEncode({
      'title': widget.title,
      'description': widget.description,
      'image': widget.image,
    });

    bookmarkedNews.add(newsData);
    await pref.setStringList('bookmarkedNews', bookmarkedNews);

  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 20,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Hero(
                    tag: widget.title.toString(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.png',
                        image: widget.image.toString(),
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title.toString(),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.notoSansArabic(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 03),
                _buildEventText(widget.description.toString(), Colors.red , context),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                    height: 55,
                    width: 160,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      color: Theme.of(context).colorScheme.primary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            const url = 'This is a url';
                            await Share.share(
                                "Title: ${widget.title}\nDescription: ${widget.description}\nApp Url: $url");
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.blue, width: 3)),
                            child: Center(
                              child: Icon(Icons.share , color:Theme.of(context).colorScheme.secondary,),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 05,
                        ),
                        Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.blue, width: 3)),
                          child: Center(
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isBookMarked = !isBookMarked;
                                    _saveBookMarkedStatus(isBookMarked);
                                  });
                                },
                                child: Icon(
                                  isBookMarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: isBookMarked ? Colors.blue : Theme.of(context).colorScheme.secondary,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildEventText(String text, Color dotColor , BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.notoSansArabic(fontSize: 15, letterSpacing: 0.1 ,                                color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    ),
  );
}

class DatesUtils {
  String dateFormatYMDKKMM() {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd , hh:mm').format(now);
    return formattedDate;
  }

  String compareTimesForSevenDays(String date) {
    DateTime dt =
        DateTime.fromMicrosecondsSinceEpoch(int.parse(date.toString()))
            .toLocal();

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    final dayBeforeYesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 2);

    String difference = '';

    final aDate = DateTime(dt.year, dt.month, dt.day);

    if (aDate == today) {
      return 'آج';
    } else if (aDate == yesterday) {
      difference = "Yesterday";
    } else if (aDate == dayBeforeYesterday) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 3 &&
        todayDate.difference(dt).inDays < 4) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 4 &&
        todayDate.difference(dt).inDays < 5) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 5 &&
        todayDate.difference(dt).inDays < 6) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 6 &&
        todayDate.difference(dt).inDays < 7) {
      difference = DateFormat('E').format(dt).toString();
    } else {
      difference =
          "${DateFormat.d().format(dt)} ${DateFormat.MMM().format(dt)} ${DateFormat.y().format(dt)}";
    }
    return difference;
  }

  String daysAgo(String date) {
    DateTime dt =
        DateTime.fromMicrosecondsSinceEpoch(int.parse(date.toString()))
            .toLocal();

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    final dayBeforeYesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 2);

    String difference = '';

    final aDate = DateTime(dt.year, dt.month, dt.day);

    if (aDate == today) {
      return 'آج';
    } else if (aDate == yesterday) {
      difference = "1d پہلے";
    } else if (aDate == dayBeforeYesterday) {
      difference = '2d پہلے';
    } else if (todayDate.difference(dt).inDays >= 3 &&
        todayDate.difference(dt).inDays < 4) {
      difference = '3d پہلے';
    } else if (todayDate.difference(dt).inDays >= 4 &&
        todayDate.difference(dt).inDays < 5) {
      difference = '4d پہلے';
    } else if (todayDate.difference(dt).inDays >= 5 &&
        todayDate.difference(dt).inDays < 6) {
      difference = '5d پہلے';
    } else if (todayDate.difference(dt).inDays >= 6 &&
        todayDate.difference(dt).inDays < 7) {
      difference = '6d پہلے';
    } else {
      difference =
          "${DateFormat.d().format(dt)} ${DateFormat.MMM().format(dt)} ${DateFormat.y().format(dt)}";
    }
    return difference;
  }

  String timesAndMinutesAgo(String timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp));
    var diff = now.difference(date);
    var time = '';

    print(diff.inMinutes);

    if (diff.inHours <= 1) {
      time = "${diff.inMinutes}m ago";
    } else if (diff.inHours <= 24) {
      time = "${diff.inHours}h ago";
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = '${diff.inDays} DAY AGO';
      } else {
        time = '${diff.inDays} DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = '${(diff.inDays / 7).floor()} WEEK AGO';
      } else {
        time = '${(diff.inDays / 7).floor()} WEEKS AGO';
      }
    }

    return time;
  }
}
