import 'dart:ui';

import 'package:bhagwat_gita/constants/app_colors.dart';
import 'package:bhagwat_gita/features/home/controller/all_chapter_controller.dart';
import 'package:bhagwat_gita/features/home/screen/app_settings_screen.dart';
import 'package:bhagwat_gita/features/verses/screen/sample_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(allChaptersProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AppSettingsScreen(),
                    ));
              },
              icon: Icon(
                Icons.settings,
                color: AppColors.textColor1,
              ))
        ],
        title: Text(
          'Bhagavad Gita Chapters',
          style: GoogleFonts.lato(
            fontSize: 26.0,
            color: AppColors.textColor1,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Center(
          child: state.allChaptersLoading
              ? Center(child: Lottie.asset("assets/icons/loading.json", height: 85.h, width: 85.w))
              : state.listOfAllChapters.isNotEmpty
                  ? HorizontalScrollView(
                      allChapter: state.listOfAllChapters,
                    )
                  : const SizedBox()),
      // bottomNavigationBar: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text(
      //       "Made with ❤️",
      //       style: TextStyle(color: AppColors.textColor1),
      //     ),
      //     TextButton(
      //         onPressed: () async {
      //           try {
      //             String endpoint = "upi://pay?pa=kumardinesh0699-1@okhdfcbank&pn=Dinesh&tn=Buy_me_coffee";
      //             Uri url = Uri.parse(endpoint);
      //             if (!await launchUrl(url)) {
      //               throw Exception('Could not launch $url');
      //             }
      //           } catch (e) {
      //             log(e.toString());
      //           }
      //         },
      //         child: const Text("Buy me a Coffee?")),
      //   ],
      // ),
    );
  }
}
