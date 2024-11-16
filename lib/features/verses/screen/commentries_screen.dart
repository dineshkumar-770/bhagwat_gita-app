import 'package:bhagwat_gita/constants/app_colors.dart';
import 'package:bhagwat_gita/features/verses/model/verse_from_chapter_model.dart';
import 'package:bhagwat_gita/features/verses/widget/commentries_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentriesScreen extends StatelessWidget {
  const CommentriesScreen({super.key, required this.chapterNumber, required this.listOfCommentary});
  final int chapterNumber;
  final List<Commentary> listOfCommentary;

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
          'Chapter $chapterNumber Commentries',
          style: GoogleFonts.lato(
            fontSize: 18.0.sp,
            color: AppColors.textColor1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: listOfCommentary.length,
            itemBuilder: (context, index) {
              return CommentriesWidget(
                id:listOfCommentary[index].id ,
                authorName: listOfCommentary[index].authorName.name.replaceAll(RegExp(r'_'), ' '),
                description: listOfCommentary[index].description,
                langauge: listOfCommentary[index].language.name,
              );
              // Text(listOfCommentary[index].description);
            },
          ))
        ],
      ),
    );
  }
}
