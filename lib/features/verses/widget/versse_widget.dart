import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:bhagwat_gita/features/verses/model/verse_from_chapter_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShlokaCard extends StatelessWidget {
  final int serialNumber;
  final String shloka;
  final List<Commentary> translations;
  final void Function()? onCommentries;

  const ShlokaCard(
      {super.key,
      required this.serialNumber,
      required this.shloka,
      required this.translations,
      this.onCommentries});

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
                'Verse $serialNumber',
                style: GoogleFonts.lato(
                  fontSize: 16.0 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.0 * SizeConfig.heightMultiplier!),
              Text(
                shloka,
                style: GoogleFonts.lato(
                  fontSize: 15.0 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0 * SizeConfig.heightMultiplier!),
              ExpansionTile(
                  title: const Text('Translations'),
                  initiallyExpanded: false,
                  children: [
                    ...translations
                        .map((translation) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(translation.description),
                                SizedBox(
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),
                                Text(
                                  'Translated by ${translation.authorName.name.replaceAll(RegExp(r'_'), ' ')} (${translation.language.name})',
                                  style: GoogleFonts.lato(
                                      fontSize:
                                          12.0 * SizeConfig.textMultiplier!,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).focusColor),
                                ),
                                const Divider(),
                              ],
                            ))
                        .toList(),
                    SizedBox(height: 10.0 * SizeConfig.heightMultiplier!),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: onCommentries,
                        child: const Text('Go to Commentries'),
                      ),
                    ),
                    SizedBox(height: 20.0 * SizeConfig.heightMultiplier!),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
