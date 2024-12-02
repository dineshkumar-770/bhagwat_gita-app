import 'package:bhagwat_gita/constants/app_colors.dart';
import 'package:bhagwat_gita/features/verses/controller/verse_from_chapters_controller.dart';
import 'package:bhagwat_gita/features/verses/model/verse_from_chapter_model.dart';
import 'package:bhagwat_gita/features/verses/widget/commentries_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ByAutherFilterCommentriesScreen extends StatefulWidget {
  const ByAutherFilterCommentriesScreen({super.key, required this.listOfCommentary});
  final List<Commentary> listOfCommentary;

  @override
  State<ByAutherFilterCommentriesScreen> createState() => _ByAutherFilterCommentriesScreenState();
}

class _ByAutherFilterCommentriesScreenState extends State<ByAutherFilterCommentriesScreen> {
  List<String> listOfAuthers = [];

  @override
  void initState() {
    initLists();
    super.initState();
  }

  void initLists() {
    for (int i = 0; i < widget.listOfCommentary.length; i++) {
      listOfAuthers.add(widget.listOfCommentary[i].authorName.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref03, _) {
      final authorState = ref03.watch(chapterVerseProvider);
      final providerFunc = ref03.read(chapterVerseProvider.notifier);
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: DropdownButtonFormField<String>(
              value: authorState.selectedAuthor.isEmpty
                  ? listOfAuthers.first
                  : authorState.selectedAuthor, // Initially no value selected
              decoration: InputDecoration(
                filled: true, // Adds background color
                fillColor: Colors.grey[200], // Light grey background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  borderSide: BorderSide.none, // No border
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0), // Padding inside dropdown
              ),
              items: listOfAuthers
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
                providerFunc.selecteAuthor(value.toString());
                providerFunc.filterCommentries(
                    filterValue: value.toString(), listOfCommentories: widget.listOfCommentary);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          authorState.filteredChapterWiseCommentries.isEmpty
              ? Center(
                  child: Text(
                    "No Commentries by ${authorState.selectedAuthor.isEmpty ? listOfAuthers.first.replaceAll("_", " ") : authorState.selectedAuthor.replaceAll("_", "")}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textColor1),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: authorState.filteredChapterWiseCommentries.length,
                    itemBuilder: (context, index) {
                      return CommentriesWidget(
                        showCommentryAuthor: false,
                        id: authorState.filteredChapterWiseCommentries[index].id,
                        authorName: authorState.filteredChapterWiseCommentries[index].authorName.name
                            .replaceAll(RegExp(r'_'), ' '),
                        description: authorState.filteredChapterWiseCommentries[index].description,
                        langauge: authorState.filteredChapterWiseCommentries[index].language.name,
                      );
                    },
                  ),
                ),
        ],
      );
    });
  }
}
