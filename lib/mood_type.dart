import 'dart:ui';
import 'package:flutter/material.dart';

enum MoodType {
  veryHappy,
  happy,
  neutral,
  sad,
  verySad
}

class Mood {
  final String name;
  final Color color;
  final MoodType type;

  Mood({this.name, this.color, this.type});
}

final moodMap = {
  MoodType.veryHappy: Mood(name: 'Labai gerai', color: Colors.lime[400], type: MoodType.veryHappy),
  MoodType.happy: Mood(name: 'Gerai', color: Colors.lightGreen[400], type: MoodType.happy),
  MoodType.neutral: Mood(name: 'Neutraliai', color: Colors.yellow[200], type: MoodType.neutral),
  MoodType.sad: Mood(name: 'Blogai', color: Colors.lightBlue[200], type: MoodType.sad),
  MoodType.verySad: Mood(name: 'Labai blogai', color: Colors.blue[400], type: MoodType.verySad),
};

/*//final externalStorage = await getExternalStorageDirectory();
    String dateFormatted1 = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final Directory tempDir = await getTemporaryDirectory();
    //final fileName = 'JournalEntry_$_selectedDate.txt';
    final File file = File('${tempDir.path}/Journal_Entry_$dateFormatted1.pdf');
    //final file = await File('${externalStorage.path}/$fileName').create();
    await file.writeAsString('$entryText');


    await Share.shareXFiles(
      [XFile(file.path, mimeType: 'application/pdf', name: 'Journal_Entry_$dateFormatted1.pdf'),],
      subject: 'Journal Entry: $dateFormatted1',
    ); */