import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChaptersCard extends StatelessWidget {
  const ChaptersCard(
      {super.key,
      required this.chapterNumber,
      required this.title,
      required this.hindiTitle,
      this.onTap});
  final int chapterNumber;
  final String title;
  final String hindiTitle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: NetworkImage(
                    'https://th.bing.com/th/id/R.e5fa063b8a6fa7b9d84fb89b166bc11d?rik=RShFTXRrtLqcJA&riu=http%3a%2f%2fwallpapercave.com%2fwp%2f1lMDG55.jpg&ehk=CyybpDopYWX%2bMEFnB7qYph994oMUitCHOb6eF7f6wcU%3d&risl=&pid=ImgRaw&r=0'),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                opacity: 0.8),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, spreadRadius: 2, blurRadius: 2)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Chapter $chapterNumber',
                style: GoogleFonts.mulish(
                  fontSize: 12.0 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.bold,
                )),
            Text(title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.mulish(
                  fontSize: 22.0 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.bold,
                )),
            Text('($hindiTitle)',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.mulish(
                  fontSize: 17.0 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
