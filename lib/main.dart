import 'dart:ui';

import 'package:bhagwat_gita/config/responsive/size_config.dart';
import 'package:bhagwat_gita/config/shared_prefs.dart';
import 'package:bhagwat_gita/features/home/screen/home_page.dart';
import 'package:bhagwat_gita/features/text_adjustment/widgets/drawer_widget.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesSingleton.init();
  runApp(const ProviderScope(child: MyApp()));
}

Color brandColor = const Color(0xffffff9f);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> key = GlobalKey();
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? dark) {
        ColorScheme lightColorScheme;
        // ignore: unused_local_variable
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
                        theme: ThemeData(
                          useMaterial3: true,
                          colorScheme: lightColorScheme,
                        ),
                        home: Scaffold(
                          key: key,
                          drawer: const Drawer(
                            elevation: 2,
                            child: DrawerWidget(),
                          ),
                          appBar: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            centerTitle: true,
                            leading: IconButton(
                                onPressed: () {
                                  key.currentState?.openDrawer();
                                },
                                icon: const Icon(Icons.menu)),
                            flexibleSpace: ClipRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 17, sigmaY: 17),
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            title: Text(
                              'Bhagavad Gita Chapters',
                              style: GoogleFonts.lato(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          body: const HomePage(),
                        ));
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
