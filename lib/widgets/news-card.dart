import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../extra/extra.dart';

class BookmarkCard extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  const BookmarkCard(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  @override
  State<BookmarkCard> createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Hero(
            tag: widget.title.toString(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                height: height * .18,
                width: width * .3,
                placeholder: 'assets/images/placeholder.png',
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    height: height * .18,
                    width: width * .3,
                    'assets/images/placeholder.png',
                    fit: BoxFit.cover,
                  );
                },
                image: widget.image,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: height * .18,
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    widget.title,
                    maxLines: 3,
                    style: GoogleFonts.notoSansArabic(
                        fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.description,
                    maxLines: 2,
                    style: GoogleFonts.notoSansArabic(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
