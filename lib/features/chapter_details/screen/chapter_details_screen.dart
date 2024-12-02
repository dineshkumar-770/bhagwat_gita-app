import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:bhagwat_gita/constants/app_colors.dart';
import 'package:bhagwat_gita/features/verses/controller/verse_from_chapters_controller.dart';
import 'package:bhagwat_gita/features/verses/screen/chapter_verse_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChaptersDetailsScreen extends ConsumerStatefulWidget {
  const ChaptersDetailsScreen(
      {super.key,
      required this.chapterMeaning,
      required this.englishPara,
      required this.chapterTitleHindi,
      required this.hindiPara,
      required this.chapterTitle,
      required this.chapterNumber,
      required this.totalVerse});
  final String chapterMeaning;
  final String englishPara;
  final String hindiPara;
  final String chapterTitle;
  final String chapterTitleHindi;
  final int chapterNumber;
  final int totalVerse;

  @override
  ConsumerState<ChaptersDetailsScreen> createState() => _ChaptersDetailsScreenState();
}

class _ChaptersDetailsScreenState extends ConsumerState<ChaptersDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.primaryButtonColor)),
          onPressed: () {
            ref.watch(chapterVerseProvider.notifier).fetchChaptersVerse(widget.chapterNumber);
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ChapterVerseScreen(chapterNumber: widget.chapterNumber),
                ));
          },
          icon: Icon(
            Icons.book,
            color: AppColors.white,
          ),
          label: Text(
            "Read Verse",
            style: GoogleFonts.lato(
              fontSize: 14.0.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.textColor1,
            )),
        centerTitle: true,
        title: Text(
          widget.chapterTitle,
          style: GoogleFonts.lato(
            fontSize: 27.0,
            color: AppColors.textColor1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16 * SizeConfig.widthMultiplier!, vertical: 16 * SizeConfig.heightMultiplier!),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        color: AppColors.textColor1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget.chapterMeaning,
                        style: GoogleFonts.lato(
                          fontSize: 16.0,
                          color: AppColors.textColor1,
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
                widget.englishPara,
                style: GoogleFonts.lato(
                  fontSize: 16.0.sp,
                  color: AppColors.textColor1,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10 * SizeConfig.heightMultiplier!,
              ),
              const Divider(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.chapterTitleHindi,
                  style: GoogleFonts.lato(
                      fontSize: 27.0.sp,
                      color: AppColors.textColor1,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier!,
              ),
              Text(
                widget.hindiPara,
                style: GoogleFonts.lato(
                  fontSize: 16.0.sp,
                  color: AppColors.textColor1,
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
