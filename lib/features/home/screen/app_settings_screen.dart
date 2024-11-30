import 'dart:developer';

import 'package:bhagwat_gita/constants/app_colors.dart';
import 'package:bhagwat_gita/features/home/controller/all_chapter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSettingsScreen extends ConsumerStatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  ConsumerState<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends ConsumerState<AppSettingsScreen> {
  List<String> colorsName = [
    "Default",
    "Soft Grey",
    "Speia Background",
    "Blue Grey Background",
    "Dark Mode Black",
    "Creamy Tint Yellow",
    "Bright White"
  ];
  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(allChaptersProvider);
    final providerFunc = ref.read(allChaptersProvider.notifier);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.textColor1,
              )),
          automaticallyImplyLeading: false,
          title: Text(
            "Settings",
            style: GoogleFonts.lato(
              fontSize: 20.0,
              color: AppColors.textColor1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              title: Text(
                "Choose Theme",
                style: TextStyle(color: AppColors.textColor1, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Choose background theme for better reading",
                style: TextStyle(color: AppColors.textColor1, fontSize: 12, fontWeight: FontWeight.w400),
              ),
              trailing: TextButton(
                onPressed: () {
                  log(themeState.selectedColorTheme);
                  providerFunc.saveThemeData(themeState.selectedColorTheme);
                  AppColors.getBackGroundColor();
                  AppColors.getTextColor();
                  AppColors.getHighlightColor();
                  // ignore: unused_result
                  ref.refresh(allChaptersProvider);
                },
                child: Text(
                  "Apply",
                  style: TextStyle(
                      color: AppColors.textColor1,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: DropdownButtonFormField<String>(
                value: themeState.selectedColorTheme, // Initially no value selected
                decoration: InputDecoration(
                  filled: true, // Adds background color
                  fillColor: Colors.grey[200], // Light grey background
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    borderSide: BorderSide.none, // No border
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Padding inside dropdown
                ),
                items: colorsName
                    .map(
                      (name) => DropdownMenuItem<String>(
                        value: name, // Set the value property here
                        child: Text(
                          name.toString(),
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
                  providerFunc.selectThemeColorName(value.toString());
                },
              ),
            ),
            ListTile(
              title: Text(
                "Build Name",
                style: TextStyle(color: AppColors.textColor1, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                themeState.packageInfo?.appName.toUpperCase() ?? "",
                style: TextStyle(color: AppColors.textColor1, fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              title: Text(
                "App version",
                style: TextStyle(color: AppColors.textColor1, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${themeState.packageInfo?.version ?? ""}-${themeState.packageInfo?.buildNumber} (L)",
                style: TextStyle(color: AppColors.textColor1, fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ));
  }
}
