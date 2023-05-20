import 'dart:ui';

import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:bhagwat_gita/features/chapter_details/screen/chapter_details_screen.dart';
import 'package:bhagwat_gita/features/home/model/all_chapters_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HorizontalScrollView extends StatefulWidget {
  final List<AllChaptersModel> allChapter;

  const HorizontalScrollView({super.key, required this.allChapter});
  @override
  // ignore: library_private_types_in_public_api
  _HorizontalScrollViewState createState() => _HorizontalScrollViewState();
}

class _HorizontalScrollViewState extends State<HorizontalScrollView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _animation =
        Tween<double>(begin: 1.0, end: 1.2).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildItem(BuildContext context, int index) {
    final isSelected = index == _selectedIndex;
    final data = widget.allChapter[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ChaptersDetailsScreen(
                chapterTitleHindi: data.name,
                chapterMeaning: data.nameMeaning,
                chapterTitle: data.nameTranslated,
                englishPara: data.chapterSummary,
                hindiPara: data.chapterSummaryHindi,
                chapterNumber: data.chapterNumber,
                totalVerse: data.versesCount,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isSelected ? 16.0 : 8.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  'https://th.bing.com/th/id/R.e5fa063b8a6fa7b9d84fb89b166bc11d?rik=RShFTXRrtLqcJA&riu=http%3a%2f%2fwallpapercave.com%2fwp%2f1lMDG55.jpg&ehk=CyybpDopYWX%2bMEFnB7qYph994oMUitCHOb6eF7f6wcU%3d&risl=&pid=ImgRaw&r=0',
                  // 'https://picsum.photos/id/$index/200/200',
                  fit: BoxFit.cover,
                  color: Colors.grey.withOpacity(isSelected ? 1 : 0.9),
                  colorBlendMode: BlendMode.modulate,
                  isAntiAlias: true,
                ),
              ), 
              if (!isSelected)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.10),
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 300 * SizeConfig.heightMultiplier!,
                  width: 180 * SizeConfig.widthMultiplier!,
                  child: Center(
                    child: Transform.scale(
                      scale: isSelected ? _animation.value : 1.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Chapter ${index + 1}',
                              style: GoogleFonts.mulish(
                                fontSize: 12.0 * SizeConfig.textMultiplier!,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(data.nameTranslated,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.mulish(
                                fontSize: 22.0 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          Text(data.name,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.mulish(
                                color: Colors.white,
                                fontSize: 17.0 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(
        height: screenHeight * 0.75,
        width: screenWidth,
        child: PageView.builder(
          padEnds: true,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.allChapter.length,
          controller: PageController(viewportFraction: 0.7),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
            _animationController.forward(from: 0.0);
          },
          itemBuilder: (context, index) => _buildItem(context, index),
        ),
      ),
    );
  }
}
