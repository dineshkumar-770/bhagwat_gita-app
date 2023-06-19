
import 'dart:ui';

import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:bhagwat_gita/features/text_to_speech/controller/text_to_speech_controller.dart';
import 'package:bhagwat_gita/features/verses/controller/verse_from_chapters_controller.dart';
import 'package:bhagwat_gita/features/verses/screen/chapter_verse_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  ConsumerState<ChaptersDetailsScreen> createState() =>
      _ChaptersDetailsScreenState();
}

class _ChaptersDetailsScreenState extends ConsumerState<ChaptersDetailsScreen> {
  @override
  void dispose() {
    ref.read(textToSpeechProvider.notifier).stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(textToSpeechProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SizedBox(
            child:
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      ref
                          .read(chapterVerseProvider.notifier)
                          .fetchChaptersVerse(widget.chapterNumber);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ChapterVerseScreen(
                                chapterNumber: widget.chapterNumber),
                          ));
                    },
                    child: Text(
                      'Read All Verse(Total:- ${widget.totalVerse})',
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
          'Chapter ${widget.chapterNumber}',
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
                  widget.chapterTitle,
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
                      onPressed: () {
                        if (state.speakingHindi) {
                        } else if (state.speakingEnglish) {
                          ref.read(textToSpeechProvider.notifier).stop();
                        } else {
                          ref
                              .read(textToSpeechProvider.notifier)
                              .speakEnglish(text: widget.englishPara);
                        }
                      },
                      icon: state.speakingEnglish
                          ? const Icon(
                              Icons.stop,
                              color: Colors.red,
                            )
                          : const Icon(Icons.volume_up)),
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
                        widget.chapterMeaning,
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
                widget.englishPara,
                style: GoogleFonts.lato(
                  fontSize: 16.0,
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
                    'Hindi:',
                    style: GoogleFonts.lato(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (state.speakingEnglish) {
                        } else if (state.speakingHindi) {
                          ref.read(textToSpeechProvider.notifier).stop();
                        } else {
                          ref.read(textToSpeechProvider.notifier).speakHindi(
                                text: widget.hindiPara,
                              );
                        }
                      },
                      icon: state.speakingHindi
                          ? const Icon(
                              Icons.stop,
                              color: Colors.red,
                            )
                          : const Icon(Icons.volume_up)),
                ],
              ),
              SizedBox(
                height: 4 * SizeConfig.heightMultiplier!,
              ),
              Text(
                widget.hindiPara,
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
