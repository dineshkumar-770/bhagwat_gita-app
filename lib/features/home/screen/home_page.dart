import 'dart:ui';

import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:bhagwat_gita/features/chapter_details/screen/chapter_details_screen.dart';
import 'package:bhagwat_gita/features/chapter_details/service/text_to_speech.dart';
import 'package:bhagwat_gita/features/home/controller/all_chapter_controller.dart';
import 'package:bhagwat_gita/features/home/widgets/chapter_card_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> backgroundImages = [
    'https://th.bing.com/th/id/R.e5fa063b8a6fa7b9d84fb89b166bc11d?rik=RShFTXRrtLqcJA&riu=http%3a%2f%2fwallpapercave.com%2fwp%2f1lMDG55.jpg&ehk=CyybpDopYWX%2bMEFnB7qYph994oMUitCHOb6eF7f6wcU%3d&risl=&pid=ImgRaw&r=0',
  ];
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
          'Bhagavad Gita Chapters',
          style: GoogleFonts.lato(
            fontSize: 24.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Center(
        child: Consumer(builder: (context, ref, _) {
          final state = ref.watch(allChaptersProvider);
          if (state is AllChaptersLoadingState) {
            return const CupertinoActivityIndicator(
              animating: true,
              radius: 20,
            );
          } else if (state is AllChaptersSuccessState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0 * SizeConfig.heightMultiplier!),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 18,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _getCrossAxisCount(context),
                          crossAxisSpacing: 10 * SizeConfig.widthMultiplier!,
                          mainAxisSpacing: 10 * SizeConfig.heightMultiplier!,
                          childAspectRatio: 16 / 9),
                      itemBuilder: (context, index) {
                        final data = state.listOfAllChapters[index];
                        return ChaptersCard(
                          chapterNumber: index + 1,
                          title: data.nameTranslated,
                          hindiTitle: data.name,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>SpeakingScreen()
                                  //  ChaptersDetailsScreen(
                                  //   chapterMeaning: data.nameMeaning,
                                  //   chapterTitle: data.nameTranslated,
                                  //   englishPara: data.chapterSummary,
                                  //   hindiPara: data.chapterSummaryHindi,
                                  //   chapterNumber: data.chapterNumber,
                                  //   totalVerse: data.versesCount,
                                  // ),
                                ));
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }

  Widget _buildChapterTile(
      BuildContext context, int chapterNumber, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: NetworkImage(
                  'https://th.bing.com/th/id/R.e5fa063b8a6fa7b9d84fb89b166bc11d?rik=RShFTXRrtLqcJA&riu=http%3a%2f%2fwallpapercave.com%2fwp%2f1lMDG55.jpg&ehk=CyybpDopYWX%2bMEFnB7qYph994oMUitCHOb6eF7f6wcU%3d&risl=&pid=ImgRaw&r=0'),
              fit: BoxFit.fill,
              opacity: 0.8),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Center(
          child: Text('Chapter $chapterNumber',
              style: GoogleFonts.mulish(
                fontSize: 18.0 * SizeConfig.textMultiplier!,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return 1;
    } else if (screenWidth < 900) {
      return 3;
    } else {
      return 4;
    }
  }

  void _showChapterSummaryDialog(
      {required BuildContext context,
      required String chapterTitle,
      required String chapterSummaryEnglish,
      required String chapterSummaryHindi}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(chapterTitle),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'English Summary',
                  style: TextStyle(
                    fontSize: 20.0 * SizeConfig.textMultiplier!,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0 * SizeConfig.heightMultiplier!),
                Text(chapterSummaryEnglish),
                SizedBox(height: 16.0 * SizeConfig.heightMultiplier!),
                Text(
                  'Hindi Summary',
                  style: TextStyle(
                    fontSize: 20.0 * SizeConfig.textMultiplier!,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0 * SizeConfig.heightMultiplier!),
                Text(chapterSummaryHindi),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
