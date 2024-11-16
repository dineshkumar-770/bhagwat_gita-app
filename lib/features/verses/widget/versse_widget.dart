import 'package:bhagwat_gita/constants/app_colors.dart';
import 'package:bhagwat_gita/features/verses/controller/verse_from_chapters_controller.dart';
import 'package:bhagwat_gita/features/verses/model/verse_from_chapter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShlokaCard extends StatelessWidget {
  final int serialNumber;
  final String shloka;
  final List<Commentary> translations;
  final void Function()? onCommentries;
  final void Function()? onSpeak;
  final bool isSpeaking;

  const ShlokaCard(
      {super.key,
      required this.serialNumber,
      required this.shloka,
      required this.translations,
      required this.isSpeaking,
      this.onCommentries,
      this.onSpeak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(
          //       Icons.arrow_back_ios,
          //       color: AppColors.textColor1,
          //     )),
          Consumer(builder: (context, ref04, _) {
            final verseState = ref04.watch(chapterVerseProvider);
            final providerFun = ref04.read(chapterVerseProvider.notifier);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: IconButton(
                onPressed: verseState.isSpeaking && serialNumber == verseState.currentTTSIndex
                    ? () {
                        providerFun.stopSpeaking();
                      }
                    : () {
                        providerFun.speakHindiTTS(shloka, serialNumber);
                      },
                icon: Icon(
                  verseState.isSpeaking && serialNumber == verseState.currentTTSIndex ? Icons.stop : Icons.volume_up,
                  color: AppColors.textColor1,
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
        child: ElevatedButton.icon(
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.primaryButtonColor)),
          onPressed: onCommentries,
          icon: Icon(
            Icons.logout,
            color: AppColors.textColor1,
          ),
          label: Text(
            'Go to Commentries',
            style: TextStyle(color: AppColors.textColor1),
          ),
        ),
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: Card(
          elevation: 2.0,
          color: AppColors.backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Verse $serialNumber \n',
                      style: GoogleFonts.lato(
                        fontSize: 16.0.sp,
                        color: AppColors.textColor1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SelectableText(
                    shloka.trim(),
                    style: GoogleFonts.lato(
                      fontSize: 18.0.sp,
                      color: AppColors.textColor3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  ...translations
                      .map((translation) => ListTile(
                            isThreeLine: true,
                            horizontalTitleGap: 0,
                            titleAlignment: ListTileTitleAlignment.titleHeight,
                            leading: const Text("⚪"),
                            title: Text(
                              translation.description.trim(),
                              style: GoogleFonts.lato(
                                fontSize: 14.0.sp,
                                color: AppColors.textColor1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Consumer(builder: (context, ref03, _) {
                              final verseState = ref03.watch(chapterVerseProvider);
                              final providerFun = ref03.read(chapterVerseProvider.notifier);
                              return InkWell(
                                onTap: verseState.isSpeaking && translation.id == verseState.currentTTSIndex
                                    ? () {
                                        providerFun.stopSpeaking();
                                      }
                                    : () {
                                        providerFun.speakHindiTTS(translation.description, translation.id);
                                      },
                                child: Icon(
                                  verseState.isSpeaking && translation.id == verseState.currentTTSIndex
                                      ? Icons.stop
                                      : Icons.volume_up,
                                  color: AppColors.textColor1,
                                ),
                              );
                            }),
                            subtitle: Text(
                              'Translated by ${translation.authorName.name.replaceAll(RegExp(r'_'), ' ')} (${translation.language.name.toLowerCase()}) ',
                              style:
                                  GoogleFonts.lato(fontSize: 10.0.sp, fontWeight: FontWeight.w500, color: AppColors.lightYellow),
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
