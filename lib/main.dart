import 'dart:developer';
import 'dart:ui';

import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:bhagwat_gita/constants/app_colors.dart';
import 'package:bhagwat_gita/features/home/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

Color brandColor = Colors.amber;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                SizeConfig().init(constraints, orientation);
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    // theme: ThemeData(
                    //   useMaterial3: true,
                    // ),
                    darkTheme: ThemeData(useMaterial3: true),
                    home: Scaffold(
                      backgroundColor: AppColors.backgroundColor,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        centerTitle: true,
                        flexibleSpace: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 17, sigmaY: 17),
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        title: Text(
                          'Bhagavad Gita Chapters',
                          style: GoogleFonts.lato(
                            fontSize: 30.0,
                            color: AppColors.textColor1,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      body: const HomePage(),
                      // bottomNavigationBar: Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       "Made with ❤️",
                      //       style: TextStyle(color: AppColors.textColor1),
                      //     ),
                      //     TextButton(
                      //         onPressed: () async {
                      //           try {
                      //             String endpoint = "upi://pay?pa=kumardinesh0699-1@okhdfcbank&pn=Dinesh&tn=Buy_me_coffee";
                      //             Uri url = Uri.parse(endpoint);
                      //             if (!await launchUrl(url)) {
                      //               throw Exception('Could not launch $url');
                      //             }
                      //           } catch (e) {
                      //             log(e.toString());
                      //           }
                      //         },
                      //         child: const Text("Buy me a Coffee?")),
                      //   ],
                      // ),
                    ));
              },
            );
          },
        );
      },
    );
  }
}
