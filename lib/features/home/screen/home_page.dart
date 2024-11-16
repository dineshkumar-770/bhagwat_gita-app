import 'package:bhagwat_gita/constants/app_colors.dart';
import 'package:bhagwat_gita/features/home/controller/all_chapter_controller.dart';
import 'package:bhagwat_gita/features/verses/screen/sample_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(builder: (context, ref, _) {
        final state = ref.watch(allChaptersProvider);
        if (state is AllChaptersLoadingState) {
          return Center(child: Lottie.asset("assets/icons/loading.json", height: 85.h, width: 85.w));
        } else if (state is AllChaptersSuccessState) {
          return HorizontalScrollView(
            allChapter: state.listOfAllChapters,
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
