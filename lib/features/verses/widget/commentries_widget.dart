import 'package:bhagwat_gita/constants/app_colors.dart';
import 'package:bhagwat_gita/features/verses/controller/verse_from_chapters_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentriesWidget extends StatelessWidget {
  const CommentriesWidget(
      {super.key,
      required this.authorName,
      required this.langauge,
      required this.description,
      required this.id,
      required this.showCommentryAuthor});
  final String authorName;
  final String langauge;
  final String description;
  final int id;
  final bool showCommentryAuthor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Card(
          color: AppColors.backgroundColor,
          child: ListTile(
            isThreeLine: showCommentryAuthor,
            minVerticalPadding: 0,
            titleAlignment: ListTileTitleAlignment.titleHeight,
            horizontalTitleGap: 0,
            leading: const Text("⚪"),
            title: Text(
              description.trim(),
              style: GoogleFonts.lato(
                fontSize: 16.0.sp,
                color: AppColors.textColor1,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: showCommentryAuthor
                ? Text(
                    'Comment by $authorName (${langauge.toLowerCase()})'.trim(),
                    style: GoogleFonts.lato(
                      fontSize: 12.sp,
                      color: AppColors.lightYellow,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : null,
            trailing: Consumer(builder: (context, ref03, _) {
              final verseState = ref03.watch(chapterVerseProvider);
              final providerFun = ref03.read(chapterVerseProvider.notifier);
              return InkWell(
                onTap: verseState.isSpeaking && id == verseState.currentTTSIndex
                    ? () {
                        providerFun.stopSpeaking();
                      }
                    : () {
                        providerFun.speakHindiTTS(description, id);
                      },
                child: Icon(
                  verseState.isSpeaking && id == verseState.currentTTSIndex ? Icons.stop : Icons.volume_up,
                  color: AppColors.textColor1,
                ),
              );
            }),
          )),
    );
  }
}
