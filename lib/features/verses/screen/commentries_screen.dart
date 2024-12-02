// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bhagwat_gita/features/verses/screen/by_auther_filter_commentries_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bhagwat_gita/constants/app_colors.dart';
import 'package:bhagwat_gita/features/verses/model/verse_from_chapter_model.dart';
import 'package:bhagwat_gita/features/verses/widget/commentries_widget.dart';

class CommentriesScreen extends StatefulWidget {
  const CommentriesScreen({
    Key? key,
    required this.chapterNumber,
    required this.listOfCommentary,
  }) : super(key: key);
  final int chapterNumber;
  final List<Commentary> listOfCommentary;

  @override
  State<CommentriesScreen> createState() => _CommentriesScreenState();
}

class _CommentriesScreenState extends State<CommentriesScreen> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.textColor1,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Chapter ${widget.chapterNumber} Commentries',
          style: GoogleFonts.lato(
            fontSize: 18.0.sp,
            color: AppColors.textColor1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: [
              Tab(
                child: Text(
                  "All",
                  style: GoogleFonts.lato(color: AppColors.textColor1, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  "By Author",
                  style: GoogleFonts.lato(color: AppColors.textColor1, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
            dividerColor: AppColors.dividerColor,
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: [
              ListView.builder(
                itemCount: widget.listOfCommentary.length,
                itemBuilder: (context, index) {
                  return CommentriesWidget(
                    showCommentryAuthor: true,
                    id: widget.listOfCommentary[index].id,
                    authorName: widget.listOfCommentary[index].authorName.name.replaceAll(RegExp(r'_'), ' '),
                    description: widget.listOfCommentary[index].description,
                    langauge: widget.listOfCommentary[index].language.name,
                  );
                  // Text(listOfCommentary[index].description);
                },
              ),
              ByAutherFilterCommentriesScreen(
                listOfCommentary: widget.listOfCommentary,
              )
            ],
          ))
        ],
      ),
      // Column(
      //   children: [
      //     Expanded(
      //         child: ListView.builder(
      //       itemCount: listOfCommentary.length,
      //       itemBuilder: (context, index) {
      //         return CommentriesWidget(
      //           id:listOfCommentary[index].id ,
      //           authorName: listOfCommentary[index].authorName.name.replaceAll(RegExp(r'_'), ' '),
      //           description: listOfCommentary[index].description,
      //           langauge: listOfCommentary[index].language.name,
      //         );
      //         // Text(listOfCommentary[index].description);
      //       },
      //     ))
      //   ],
      // ),
    );
  }
}
