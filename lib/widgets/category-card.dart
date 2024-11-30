import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCardWidget extends StatefulWidget {
  final String title;
  final String image;
  final VoidCallback onTap;
  const CategoryCardWidget(
      {super.key,
        required this.title,
        required this.image,
        required this.onTap});

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.cover,
                opacity: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.title.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansArabic(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}