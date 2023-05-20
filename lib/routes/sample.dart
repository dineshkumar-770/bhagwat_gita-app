import 'package:bhagwat_gita/features/chapter_details/controller/text_size_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class SampleText extends ConsumerStatefulWidget {
  const SampleText({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SampleTextState();
}

class _SampleTextState extends ConsumerState<SampleText> {
  @override
  Widget build(BuildContext context) {
    final adjustSize = ref.watch(textAdjustProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Slider(
              value: adjustSize,
              onChanged: (value) {
                ref.read(textAdjustProvider.notifier).adjustTextSize(value);
              }),
          Text(
            'My Name',
            style: TextStyle(
                fontSize: adjustSize == 0 ? 12 : 12 * (adjustSize * 10)),
          )
        ],
      ),
    );
  }
}
