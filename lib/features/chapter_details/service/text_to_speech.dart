import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeakingScreen extends StatefulWidget {
  @override
  _SpeakingScreenState createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  FlutterTts flutterTts = FlutterTts();
  String text =
      'भगवद गीता का पहला अध्याय अर्जुन विशाद योग उन पात्रों और परिस्थितियों का परिचय कराता है जिनके कारण पांडवों और कौरवों के बीच महाभारत का महासंग्राम हुआ। यह अध्याय उन कारणों का वर्णन करता है जिनके कारण भगवद गीता का ईश्वरावेश हुआ। जब महाबली योद्धा अर्जुन दोनों पक्षों पर युद्ध के लिए तैयार खड़े योद्धाओं को देखते हैं तो वह अपने ही रिश्तेदारों एवं मित्रों को खोने के डर तथा फलस्वरूप पापों के कारण दुखी और उदास हो जाते हैं। इसलिए वह श्री कृष्ण को पूरी तरह से आत्मसमर्पण करते हैं। इस प्रकार, भगवद गीता के ज्ञान का प्रकाश होता है।';
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _speak() async {
    await flutterTts.setLanguage('hi');
    await flutterTts.setPitch(1); // Lower pitch for deeper voice
    await flutterTts.setSpeechRate(0.1); // Slightly slower speech rate
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
    await flutterTts.awaitSpeakCompletion(true).then((value) => log('hogya'));//when speak completed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speaking Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(text),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _speak,
                child: Text('Speak'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Text highlighting class......

/*
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeakingScreen extends StatefulWidget {
  @override
  _SpeakingScreenState createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  FlutterTts flutterTts = FlutterTts();
  String _text =
      'भगवद गीता का पहला अध्याय अर्जुन विशाद योग उन पात्रों और परिस्थितियों का परिचय कराता है जिनके कारण पांडवों और कौरवों के बीच महाभारत का महासंग्राम हुआ। यह अध्याय उन कारणों का वर्णन करता है जिनके कारण भगवद गीता का ईश्वरावेश हुआ। जब महाबली योद्धा अर्जुन दोनों पक्षों पर युद्ध के लिए तैयार खड़े योद्धाओं को देखते हैं तो वह अपने ही रिश्तेदारों एवं मित्रों को खोने के डर तथा फलस्वरूप पापों के कारण दुखी और उदास हो जाते हैं। इसलिए वह श्री कृष्ण को पूरी तरह से आत्मसमर्पण करते हैं। इस प्रकार, भगवद गीता के ज्ञान का प्रकाश होता है।';
  List<Word> _words = [];
  int _currentIndex = -1;

  @override
  void initState() {
    super.initState();
    _words = _buildWords();
    flutterTts.setCompletionHandler(() {
      setState(() {
        _currentIndex = -1;
      });
    });
  }

  List<Word> _buildWords() {
    List<String> wordList = _text.split(' ');
    List<Word> words = [];
    for (int i = 0; i < wordList.length; i++) {
      words.add(Word(text: wordList[i], highlighted: false));
    }
    return words;
  }

  Future<void> _speak() async {
    await flutterTts.setLanguage('hi');
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.1);
    await flutterTts.setVolume(1.0);

    for (int i = 0; i < _words.length; i++) {
      setState(() {
        _currentIndex = i;
        _words[i].highlighted = true;
      });

      await flutterTts.speak(_words[i].text);
      await flutterTts.awaitSpeakCompletion(true);
      setState(() {
        _currentIndex = -1;
        _words[i].highlighted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speaking Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectableText.rich(
                TextSpan(
                  children: _words.map((word) {
                    return TextSpan(
                      text: word.text + ' ',
                      style: TextStyle(
                        fontWeight: word.highlighted
                            ? FontWeight.bold
                            : FontWeight.normal,
                        backgroundColor:
                            word.highlighted ? Colors.grey : Colors.transparent,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _speak,
                child: Text('Speak'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Word {
  final String text;
  bool highlighted;

  Word({required this.text, required this.highlighted});
}

 */