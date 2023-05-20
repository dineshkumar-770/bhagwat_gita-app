import 'dart:ui';

import 'package:bhagwat_gita/features/verses/model/verse_from_chapter_model.dart';
import 'package:bhagwat_gita/features/verses/widget/commentries_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentriesScreen extends StatelessWidget {
  const CommentriesScreen(
      {super.key, required this.chapterNumber, required this.listOfCommentary});
  final int chapterNumber;
  final List<Commentary> listOfCommentary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 17, sigmaY: 17),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        title: Text(
          'Chapter $chapterNumber Commentries',
          style: GoogleFonts.lato(
            fontSize: 24.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: listOfCommentary.length,
            itemBuilder: (context, index) {
              return CommentriesWidget(
                authorName: listOfCommentary[index]
                    .authorName
                    .name
                    .replaceAll(RegExp(r'_'), ' '),
                description: listOfCommentary[index].description,
                langauge: listOfCommentary[index].language.name,
              );
              // Text(listOfCommentary[index].description);
            },
          ))
        ],
      ),
    );
  }
}
