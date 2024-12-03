// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bhagwat_gita/features/verses/controller/verse_from_chapters_controller.dart';
import 'package:bhagwat_gita/features/verses/widget/commentries_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bhagwat_gita/constants/app_colors.dart';

class AllCommentriesOfChapterScreen extends StatelessWidget {
  const AllCommentriesOfChapterScreen({
    Key? key,
    required this.chapterNumber,
  }) : super(key: key);
  final String chapterNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.textColor1,
            )),
        centerTitle: true,
        title: Text(
          "Commentries Chapter $chapterNumber",
          style: GoogleFonts.lato(
            fontSize: 27.0,
            color: AppColors.textColor1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref10, child) {
          final commentState = ref10.watch(chapterVerseProvider);
          final providerFunc = ref10.read(chapterVerseProvider.notifier);
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: DropdownButtonFormField<String>(
                  value: commentState.listOfAllAuthorsOfCommentries.isEmpty
                      ? null
                      : commentState.listOfAllAuthorsOfCommentries.first, // Initially no value selected
                  decoration: InputDecoration(
                    filled: true, // Adds background color
                    fillColor: Colors.grey[200], // Light grey background
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      borderSide: BorderSide.none, // No border
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0), // Padding inside dropdown
                  ),
                  items: commentState.listOfAllAuthorsOfCommentries
                      .map(
                        (name) => DropdownMenuItem<String>(
                          value: name, // Set the value property here
                          child: Text(
                            name.replaceAll("_", " "),
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    providerFunc.selectAllCommentriesAuthor(value.toString());
                    providerFunc.filterAllCommentriesOfChapter(value.toString());
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              commentState.filteredListOfAllCommentriesInAChapter.isEmpty
                  ? Center(
                      child: Text(
                        "No Commentries by ${commentState.selectedAllCommentriesAuthor.replaceAll("_", "")}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textColor1),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                      itemCount: commentState.filteredListOfAllCommentriesInAChapter.length,
                      itemBuilder: (context, index) {
                        return CommentriesWidget(
                          showCommentryAuthor: false,
                          id: commentState.filteredListOfAllCommentriesInAChapter[index].id,
                          authorName: commentState.filteredListOfAllCommentriesInAChapter[index].authorName.name
                              .replaceAll(RegExp(r'_'), ' '),
                          description: commentState.filteredListOfAllCommentriesInAChapter[index].description,
                          langauge: commentState.filteredListOfAllCommentriesInAChapter[index].language.name,
                        );
                      },
                    ))
            ],
          );
        },
      ),
    );
  }
}
