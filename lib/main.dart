import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:bhagwat_gita/features/home/screen/home_page.dart';
import 'package:bhagwat_gita/features/home/widgets/chapter_card.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

Color brandColor = const Color(0xffffff9f);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? dark) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && dark != null) {
          lightColorScheme = lightDynamic.harmonized()..copyWith();
          lightColorScheme = lightColorScheme.copyWith(secondary: brandColor);
          darkColorScheme = dark.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: brandColor);
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: brandColor,
            brightness: Brightness.dark,
          );
        }
        return ScreenUtilInit(
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return OrientationBuilder(
                  builder: (context, orientation) {
                    SizeConfig().init(constraints, orientation);
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(useMaterial3: true,colorScheme: lightColorScheme),
                      darkTheme: ThemeData(useMaterial3: true,colorScheme: darkColorScheme),
                      home: const HomePage(),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
