import 'dart:developer';
import 'package:bhagwat_gita/config/shared_prefs.dart';
import 'package:bhagwat_gita/features/text_adjustment/controller/text_adjustment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(textSizeProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExpansionTile(
          title: const Text('Adjust Text Size'),
          leading: const Icon(Icons.text_increase),
          children: [
            Slider(
              value: ref.read(textSizeProvider.notifier).state,
              divisions: 15,
              label: 'Slide to adjust value',
              onChanged: (value) {
                ref.read(textSizeProvider.notifier).state = value;
                log('${ref.read(textSizeProvider.notifier).state}');
              },
            ),
            Text(
              'This is a sample text',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: ref.read(textSizeProvider.notifier).state * 100),
            ),
            ElevatedButton(
                onPressed: () {
                  final fontText =
                      ((ref.read(textSizeProvider.notifier).state) * 100)
                          .toStringAsFixed(0);
                  SharedPreferencesSingleton.instance
                      .setDouble('textSize', double.parse(fontText))
                      .then((value) => debugPrint(
                          '${SharedPreferencesSingleton.instance.getDouble('textSize')}'));
                },
                child: const Text('Save'))
          ],
        ),
      ],
    );
  }
}
