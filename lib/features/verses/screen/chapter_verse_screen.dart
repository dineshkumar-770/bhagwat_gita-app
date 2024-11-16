import 'dart:developer';

import 'package:bhagwat_gita/constants/app_colors.dart';
import 'package:bhagwat_gita/features/verses/controller/verse_from_chapters_controller.dart';
import 'package:bhagwat_gita/features/verses/screen/commentries_screen.dart';
import 'package:bhagwat_gita/features/verses/widget/versse_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_flip/page_flip.dart';

class ChapterVerseScreen extends StatefulWidget {
  const ChapterVerseScreen({super.key, required this.chapterNumber});
  final int chapterNumber;

  @override
  State<ChapterVerseScreen> createState() => _ChapterVerseScreenState();
}

class _ChapterVerseScreenState extends State<ChapterVerseScreen> {
  final _controller = GlobalKey<PageFlipWidgetState>();
  Future _showPopupMenu({required Offset offset, required List<PopupMenuEntry<String>> items}) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: items,
      elevation: 8.0,
    );
  }

  PageController pageController = PageController(initialPage: 0, viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.textColor1,
            )),
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        actions: [
          Consumer(builder: (context, ref03, _) {
            final pageState = ref03.watch(chapterVerseProvider);
            return pageState.verseLoading
                ? const SizedBox()
                : TextButton(
                    onPressed: () {
                      _showPopupMenu(
                          offset: const Offset(12, -12),
                          items: List.generate(
                            pageState.chapterVerseList.length,
                            (index) => PopupMenuItem<String>(
                                onTap: () {
                                  log("Selected Verse Value: ${index + 1}");
                                  // if (_controller.currentContext?.mounted ?? false) {

                                  // }
                                  pageController.animateToPage(index,
                                      duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                                },
                                value: '${index + 1}',
                                child: Text('Verse ${index + 1}')),
                          ));
                    },
                    child: const Text("Jump to Verse"));
          })
        ],
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref02, child) {
            final verseState = ref02.watch(chapterVerseProvider);
            if (verseState.verseLoading) {
              return Center(child: Lottie.asset("assets/icons/loading.json", height: 85.h, width: 85.w));
            } else {
              if (verseState.errorMessage.isNotEmpty) {
                return Center(
                    child: Text(
                  verseState.errorMessage,
                  style: GoogleFonts.lato(
                    fontSize: 14.0.sp,
                    color: AppColors.textColor1,
                    fontWeight: FontWeight.w500,
                  ),
                ));
              } else {
                return PageView.builder(
                  itemCount: verseState.chapterVerseList.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return ShlokaCard(
                      serialNumber: index + 1,
                      onSpeak: () {},
                      isSpeaking: verseState.isSpeaking,
                      onCommentries: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CommentriesScreen(
                                  listOfCommentary: verseState.chapterVerseList[index].commentaries,
                                  chapterNumber: widget.chapterNumber),
                            ));
                      },
                      shloka: verseState.chapterVerseList[index].text.toString(),
                      translations: verseState.chapterVerseList[index].translations,
                    );
                  },
                );
                // PageFlipWidget(
                //     key: _controller,
                //     cutoffForward: 1,
                //     backgroundColor: AppColors.backgroundColor,
                //     duration: const Duration(milliseconds: 700),
                //     lastPage: Container(color: Colors.white, child: const Center(child: Text('Last Page!'))),
                //     children: List.generate(
                //         verseState.chapterVerseList.length,
                //         (index) => ShlokaCard(
                //               serialNumber: index + 1,
                //               onSpeak: () {},
                //               isSpeaking: verseState.isSpeaking,
                //               onCommentries: () {
                //                 Navigator.push(
                //                     context,
                //                     CupertinoPageRoute(
                //                       builder: (context) => CommentriesScreen(
                //                           listOfCommentary: verseState.chapterVerseList[index].commentaries,
                //                           chapterNumber: widget.chapterNumber),
                //                     ));
                //               },
                //               shloka: verseState.chapterVerseList[index].text.toString(),
                //               translations: verseState.chapterVerseList[index].translations,
                //             )));
              }
            }
          },
        ),
      ),
    );
  }
}
