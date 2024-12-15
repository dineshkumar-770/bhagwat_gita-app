import 'dart:ui';

import 'package:bhagwat_gita/features/home/controller/all_chapter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class BhagavadGitaChaptersCard extends StatelessWidget {
  const BhagavadGitaChaptersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          title: Text(
            'Bhagavad Gita Chapters',
            style: GoogleFonts.lato(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.yellow[200],
        body: Card(
          color: Colors.yellow[200],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer(builder: (context, ref, _) {
              final state = ref.watch(allChaptersProvider);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.listOfAllChapters.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _getCrossAxisCount(context),
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (context, index) {
                        return _buildChapterTile(
                          context,
                          index + 1,
                          () {
                            ref
                                .read(allChaptersProvider.notifier)
                                .fetchAllChapters();
                            _showChapterSummaryDialog(
                                chapterSummaryEnglish:
                                    state.allChaptersLoading
                                        ? 'Loading...'
                                        : state.allChapterErrorMsg.isNotEmpty
                                            ? state.allChapterErrorMsg
                                            : state.listOfAllChapters.isNotEmpty
                                                ? state.listOfAllChapters[index]
                                                    .chapterSummary
                                                : '',
                                chapterSummaryHindi:
                                    state.allChaptersLoading
                                        ? 'Loading...'
                                        : state.allChapterErrorMsg.isNotEmpty
                                            ? state.allChapterErrorMsg
                                            : state.listOfAllChapters.isNotEmpty
                                                ? state.listOfAllChapters[index]
                                                    .chapterSummaryHindi
                                                : '',
                                chapterTitle: state.allChaptersLoading
                                    ? 'Loading...'
                                    : state.allChapterErrorMsg.isNotEmpty
                                        ? state.allChapterErrorMsg
                                        : state.listOfAllChapters.isNotEmpty
                                            ? state.listOfAllChapters[index]
                                                .nameMeaning
                                            : '',
                                context: context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
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
              style: GoogleFonts.lato(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return 2;
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
                const Text(
                  'English Summary',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(chapterSummaryEnglish),
                const SizedBox(height: 16.0),
                const Text(
                  'Hindi Summary',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
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
