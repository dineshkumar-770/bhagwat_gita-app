// To parse this JSON data, do
//
//     final verseFromChapterModel = verseFromChapterModelFromJson(jsonString);

import 'dart:convert';

List<VerseFromChapterModel> verseFromChapterModelFromJson(String str) => List<VerseFromChapterModel>.from(json.decode(str).map((x) => VerseFromChapterModel.fromJson(x)));

String verseFromChapterModelToJson(List<VerseFromChapterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VerseFromChapterModel {
    int id;
    int verseNumber;
    int chapterNumber;
    String slug;
    String text;
    String transliteration;
    String wordMeanings;
    List<Commentary> translations;
    List<Commentary> commentaries;

    VerseFromChapterModel({
        required this.id,
        required this.verseNumber,
        required this.chapterNumber,
        required this.slug,
        required this.text,
        required this.transliteration,
        required this.wordMeanings,
        required this.translations,
        required this.commentaries,
    });

    factory VerseFromChapterModel.fromJson(Map<String, dynamic> json) => VerseFromChapterModel(
        id: json["id"],
        verseNumber: json["verse_number"],
        chapterNumber: json["chapter_number"],
        slug: json["slug"],
        text: json["text"],
        transliteration: json["transliteration"],
        wordMeanings: json["word_meanings"],
        translations: List<Commentary>.from(json["translations"].map((x) => Commentary.fromJson(x))),
        commentaries: List<Commentary>.from(json["commentaries"].map((x) => Commentary.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "verse_number": verseNumber,
        "chapter_number": chapterNumber,
        "slug": slug,
        "text": text,
        "transliteration": transliteration,
        "word_meanings": wordMeanings,
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
        "commentaries": List<dynamic>.from(commentaries.map((x) => x.toJson())),
    };
}

class Commentary {
    int id;
    String description;
    AuthorName authorName;
    Language language;

    Commentary({
        required this.id,
        required this.description,
        required this.authorName,
        required this.language,
    });

    factory Commentary.fromJson(Map<String, dynamic> json) => Commentary(
        id: json["id"],
        description: json["description"],
        authorName: authorNameValues.map[json["author_name"]]!,
        language: languageValues.map[json["language"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author_name": authorNameValues.reverse[authorName],
        "language": languageValues.reverse[language],
    };
}

// ignore: constant_identifier_names
enum AuthorName { SRI_SHANKARACHARYA, SWAMI_CHINMAYANANDA, SRI_ANANDGIRI, SRI_DHANPATI, SRI_MADHAVACHARYA, SRI_NEELKANTH, SRI_RAMANUJACHARYA, SRI_SRIDHARA_SWAMI, SRI_VEDANTADESHIKACHARYA_VENKATANATHA, SWAMI_RAMSUKHDAS, SWAMI_SIVANANDA, SRI_VALLABHACHARYA, SRI_ABHINAVGUPTA, SRI_JAYATRITHA, SRI_MADHUSUDAN_SARASWATI, SRI_PURUSHOTTAMJI, SWAMI_ADIDEVANANDA, SWAMI_GAMBIRANANDA, SWAMI_TEJOMAYANANDA, DR_S_SANKARANARAYAN, SHRI_PUROHIT_SWAMI }

final authorNameValues = EnumValues({
    "Dr. S. Sankaranarayan": AuthorName.DR_S_SANKARANARAYAN,
    "Shri Purohit Swami": AuthorName.SHRI_PUROHIT_SWAMI,
    "Sri Abhinavgupta": AuthorName.SRI_ABHINAVGUPTA,
    "Sri Anandgiri": AuthorName.SRI_ANANDGIRI,
    "Sri Dhanpati": AuthorName.SRI_DHANPATI,
    "Sri Jayatritha": AuthorName.SRI_JAYATRITHA,
    "Sri Madhavacharya": AuthorName.SRI_MADHAVACHARYA,
    "Sri Madhusudan Saraswati": AuthorName.SRI_MADHUSUDAN_SARASWATI,
    "Sri Neelkanth": AuthorName.SRI_NEELKANTH,
    "Sri Purushottamji": AuthorName.SRI_PURUSHOTTAMJI,
    "Sri Ramanujacharya": AuthorName.SRI_RAMANUJACHARYA,
    "Sri Shankaracharya": AuthorName.SRI_SHANKARACHARYA,
    "Sri Sridhara Swami": AuthorName.SRI_SRIDHARA_SWAMI,
    "Sri Vallabhacharya": AuthorName.SRI_VALLABHACHARYA,
    "Sri Vedantadeshikacharya Venkatanatha": AuthorName.SRI_VEDANTADESHIKACHARYA_VENKATANATHA,
    "Swami Adidevananda": AuthorName.SWAMI_ADIDEVANANDA,
    "Swami Chinmayananda": AuthorName.SWAMI_CHINMAYANANDA,
    "Swami Gambirananda": AuthorName.SWAMI_GAMBIRANANDA,
    "Swami Ramsukhdas": AuthorName.SWAMI_RAMSUKHDAS,
    "Swami Sivananda": AuthorName.SWAMI_SIVANANDA,
    "Swami Tejomayananda": AuthorName.SWAMI_TEJOMAYANANDA
});

// ignore: constant_identifier_names
enum Language { SANSKRIT, HINDI, ENGLISH }

final languageValues = EnumValues({
    "english": Language.ENGLISH,
    "hindi": Language.HINDI,
    "sanskrit": Language.SANSKRIT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
