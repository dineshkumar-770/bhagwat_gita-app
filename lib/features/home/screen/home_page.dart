import 'package:bhagwat_gita/features/home/controller/all_chapter_controller.dart';
import 'package:bhagwat_gita/features/verses/screen/sample_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          return const CupertinoActivityIndicator(
            animating: true,
            radius: 20,
          );
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
