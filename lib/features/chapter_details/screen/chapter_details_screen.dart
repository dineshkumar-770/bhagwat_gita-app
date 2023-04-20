import 'dart:ui';

import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChaptersDetailsScreen extends StatelessWidget {
  const ChaptersDetailsScreen(
      {super.key,
      required this.chapterMeaning,
      required this.englishPara,
      required this.hindiPara,
      required this.chapterTitle,
      required this.chapterNumber,
      required this.totalVerse});
  final String chapterMeaning;
  final String englishPara;
  final String hindiPara;
  final String chapterTitle;
  final int chapterNumber;
  final int totalVerse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Read All Verse(Total:- $totalVerse)',
                      style: GoogleFonts.lato(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.bookmark_add)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                  ],
                )
              ],
            ),
          ),
        ),
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
          chapterTitle,
          style: GoogleFonts.lato(
            fontSize: 24.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 12 * SizeConfig.widthMultiplier!,
              vertical: 12 * SizeConfig.heightMultiplier!),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Chapter $chapterNumber',
                  style: GoogleFonts.lato(
                    fontSize: 27.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'English:',
                    style: GoogleFonts.lato(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.volume_up)),
                ],
              ),
              SizedBox(
                height: 4 * SizeConfig.heightMultiplier!,
              ),
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meaning:  ',
                      style: GoogleFonts.lato(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        chapterMeaning,
                        style: GoogleFonts.lato(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10 * SizeConfig.heightMultiplier!,
              ),
              Text(
                englishPara,
                style: GoogleFonts.lato(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 22 * SizeConfig.heightMultiplier!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hindi:',
                    style: GoogleFonts.lato(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.volume_up)),
                ],
              ),
              SizedBox(
                height: 4 * SizeConfig.heightMultiplier!,
              ),
              Text(
                hindiPara,
                style: GoogleFonts.lato(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
