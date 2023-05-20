import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentriesWidget extends StatelessWidget {
  const CommentriesWidget(
      {super.key,
      required this.authorName,
      required this.langauge,
      required this.description});
  final String authorName;
  final String langauge;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 10.0 * SizeConfig.widthMultiplier!,
          vertical: 6.0 * SizeConfig.heightMultiplier!),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20.0 * SizeConfig.widthMultiplier!,
              vertical: 10.0 * SizeConfig.heightMultiplier!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                description,
                style: GoogleFonts.lato(
                  fontSize: 16.0 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.0 * SizeConfig.heightMultiplier!),
              Text(
                'Comment by $authorName ($langauge)',
                style: GoogleFonts.lato(
                  fontSize: 15.0 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0 * SizeConfig.heightMultiplier!),
            ],
          ),
        ),
      ),
    );
  }
}
