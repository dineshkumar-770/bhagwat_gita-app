import 'dart:ui';

import 'package:bhagwat_gita/features/verses/controller/verse_from_chapter_state.dart';
import 'package:bhagwat_gita/features/verses/controller/verse_from_chapters_controller.dart';
import 'package:bhagwat_gita/features/verses/screen/commentries_screen.dart';
import 'package:bhagwat_gita/features/verses/widget/versse_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ChapterVerseScreen extends StatelessWidget {
  const ChapterVerseScreen({super.key, required this.chapterNumber});
  final int chapterNumber;

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
          'Chapter $chapterNumber Verse',
          style: GoogleFonts.lato(
            fontSize: 24.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(chapterVerseProvider);
          if (state is ChapterVerseLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is ChapterVerseSuccessState) {
            return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.chapterVerseList.length,
                  itemBuilder: (context, index) {
                    return ShlokaCard(
                      serialNumber: index + 1,
                      onCommentries: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CommentriesScreen(
                                  listOfCommentary: state
                                      .chapterVerseList[index].commentaries,
                                  chapterNumber: chapterNumber),
                            ));
                      },
                      shloka: state.chapterVerseList[index].text.toString(),
                      translations: state.chapterVerseList[index].translations,
                    );
                  },
                ))
              ],
            );
          } else if (state is ChapterVerseErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text('Kuch tho gadbad hai!'),
            );
          }
        },
      ),
    );
  }
}
