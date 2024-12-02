import 'dart:developer';
import 'dart:ui';

import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:bhagwat_gita/features/home/screen/home_page.dart';
import 'package:bhagwat_gita/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
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
                    debugShowCheckedModeBanner: false, darkTheme: ThemeData(useMaterial3: true), home: const HomePage());
              },
            );
          },
        );
      },
    );
  }
}
