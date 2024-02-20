import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'event_interface.dart';
import 'package:intl/intl.dart';
import 'mood_type.dart';

class JournalEntry extends StatefulWidget implements EventInterface {

  int id;
  @required DateTime date;
  MoodType mood;
  List<String> entries;

  JournalEntry({this.id, @required this.date, @required this.mood, this.entries});

  @override
  DateTime get eventDate => date;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date?.millisecondsSinceEpoch ?? 0,
      'mood': mood?.index ?? 0,
      for (int i = 0; i < entries.length; i++)
        'entry${i + 1}': entries[i] ?? '',
    };
  }

  static JournalEntry fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      mood: MoodType.values[map['mood']],
      entries: [
        for (int i = 0; i < 10; i++)
          map['entry${i + 1}'] ?? '',
      ],
    );
  }

  @override
  _JournalEntryState createState() => _JournalEntryState();
}

class _JournalEntryState extends State<JournalEntry> {

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class JournalEntryScreen extends StatefulWidget {

  DateTime selectedDate;
  JournalEntry entry;
  Mood selectedMood;

  JournalEntryScreen({
    Key key,
    this.selectedDate,
    this.entry, this.selectedMood}) : super(key: key);

  @override
  _JournalEntryScreenState createState() => _JournalEntryScreenState();

}

class _JournalEntryScreenState extends State<JournalEntryScreen> {
  DateTime _selectedDate;
  final _formKey = GlobalKey<FormState>();
  //TextEditingController _journalEntryController = TextEditingController(); // nepamirsti istrinti veliau
  List<TextEditingController> _journalEntryControllers = List.generate(10, (_) => TextEditingController());
  String _journalEntry = '';
  MoodType _selectedMood;
  int id;

  @override
  void initState() {
    super.initState();

    if (widget.entry != null) {
      id = widget.entry.id;
      _selectedDate = widget.entry.date;
      _selectedMood = widget.entry.mood;
      //_journalEntryController = TextEditingController(text: widget.entry.entry);
      for (int i=0; i<_journalEntryControllers.length; i++) {
        _journalEntryControllers[i].text = widget.entry.entries[i] ?? '';
      }
    } else if (widget.selectedDate != null) {
      _selectedDate = widget.selectedDate;
      _selectedMood = MoodType.neutral;
      //_journalEntryController = TextEditingController();
      for (int i=0; i<_journalEntryControllers.length; i++) {
        _journalEntryControllers[i] = TextEditingController();
      }
    } else {
      _selectedDate = DateTime.now();
      _selectedMood = MoodType.neutral;
      //_journalEntryController = TextEditingController();
      for (int i = 0; i < _journalEntryControllers.length; i++) {
        _journalEntryControllers[i] = TextEditingController();
      }
    }
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    var args = ModalRoute.of(context).settings.arguments;
    if (args is JournalEntry) {
      setState(() {
        _selectedDate = args.date;
        _selectedMood = args.mood;
        for (int i=0; i< _journalEntryControllers.length; i++) {
          _journalEntryControllers[i].text = args.entries[i] ?? '';
        }
      });
    }
    else if (args is Map<String, dynamic> && args['selectedDate'] != null) {
      setState(() {
        _selectedDate = args['selectedDate'] as DateTime;
        _selectedMood = MoodType.neutral;
        for (int i=0; i< _journalEntryControllers.length; i++) {
          _journalEntryControllers[i] = TextEditingController();
        }
      });
    }
    //print('JournalEntryScreen didChangeDependencies: entry=${widget.entry?.entries}');
  }

  List<Widget> _buildJournalEntrySections() {
    return [
      _buildJournalEntrySection('Situacija', 'Koks įvykis (išorinis ar vidinis) '
          'yra susijęs su jaučiama nemalonia emocija? Koks elgesys, į kurį įsitraukėte, '
          'buvo nenaudingas?', 0),
      _buildJournalEntrySection('Automatinės mintys', 'Kokios mintys ir vaizdai '
          'kilo jūsų galvoje (prieš, įvykio metu arba po jo, taip pat nenaudingo elgesio '
          'metu)?', 1, 'Kaip stipriai tikite šiomis mintimis?', 2),
      _buildJournalEntrySection('Emocijos', 'Kokias emocijas (pvz.: liūdesį, nerimą, pyktį, nusivylimą, baimę) '
          'jautėte įvykio metu ar po jo? ', 3, 'Kokio intensyvumo buvo šios emocijos?', 4),
      _buildJournalEntrySection('Adaptyvus atsakas', 'Kokį kognityvinį iškraipymą, '
          'atsiradusį reaguojant į įvykį, pastebite?', 5, 'Suformuluokite adaptyvų atsaką naudodamiesi informacijos skiltyje pateiktais automatinių minčių tikrinimo klausimais. Kaip stipriai tikite šiuo atsaku?', 6),
      _buildJournalEntrySection('Išvados', 'Kiek dabar tikite anksčiau aprašytomis'
          ' automatinėmis mintimis?', 7, 'Kokias emocijas jaučiate dabar? '
          'Kokio intensyvumo yra šios emocijos?', 8, 'Ką dar būtų galima padaryti?', 9)
    ];
  }

    Widget _buildJournalEntrySection(String label, String description1, int index1,
        [String description2, int index2, String description3, int index3]) {
      List<Widget> children = [
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
          child: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(description1, style: TextStyle(fontSize: 16)),
        ),
        TextFormField(
          controller: _journalEntryControllers[index1],
          decoration: InputDecoration(
            hintText: 'Įveskite įrašą',
            border: OutlineInputBorder(),
          ),
          maxLines: null,
        ),
      ];

      if (description2 != null && index2 != null) {
        children.addAll([
          Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(description2, style: TextStyle(fontSize: 16)),
          ),
          TextFormField(
            controller: _journalEntryControllers[index2],
            decoration: InputDecoration(
              hintText: 'Įveskite įrašą',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),
        ]);
      }

      if (description3 != null && index3 != null) {
        children.addAll([
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(description3, style: TextStyle(fontSize: 16)),
          ),
          TextFormField(
            controller: _journalEntryControllers[index3],
            decoration: InputDecoration(
              hintText: 'Įveskite įrašą',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),
        ]);
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
      ),
    );
  }

  /*void deleteEntryM() async {
    print('Delete button pressed');
    print('Widget entry: ${widget.entry}');
    print('Entry ID to delete: ${widget.entry?.id}');
    if (widget.entry  != null) {
      try {
        int result = await DatabaseHelper.instance.deleteEntry(widget.entry.id);
        print('Delete result: $result');
      } catch (error) {
        print('Delete error: $error');
      }
      List<JournalEntry> entries = await DatabaseHelper.instance.getEntries();
      print('Entries after deletion: $entries');
    } else {
      print('No entry to delete');
    }
    Navigator.pop(context, true);
  }*/

  Future<void> shareEntryM() async {
    String dateFormatted = DateFormat.yMMMMd().format(_selectedDate);
    String mood = moodMap[_selectedMood].name;
    String entryText = 'Data: $dateFormatted\nNuotaika: $mood\n\n';
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Storage permission is required to save the file.'),
          ),
        );
        return;
      }
    }
     const List<String> labels = [
       'Situacija',
       'Automatinės mintys',
       'Automatinės mintys',
       'Emocijos',
       'Emocijos',
       'Adaptyvus atsakas',
       'Adaptyvus atsakas',
       'Išvados',
       'Išvados',
       'Išvados',
    ];

    const List<String> descriptions = [
      'Koks įvykis (išorinis ar vidinis) yra susijęs su jaučiama nemalonia emocija? Koks elgesys, į kurį įsitraukėte, buvo nenaudingas?',
      'Kokios mintys ir vaizdai kilo jūsų galvoje (prieš, įvykio metu arba po jo, taip pat nenaudingo elgesio metu)?',
      'Kaip stipriai tikite šiomis mintimis?',
      'Kokias emocijas (pvz.: liūdesį, nerimą, pyktį, nusivylimą, baimę) jautėte įvykio metu ar po jo?',
      'Kokio intensyvumo buvo šios emocijos?',
      'Kokį kognityvinį iškraipymą, atsiradusį reaguojant į įvykį, pastebite?',
      'Suformuluokite adaptyvų atsaką naudodamiesi informacijos skiltyje pateiktais automatinių minčių tikrinimo klausimais. Kaip stipriai tikite šiuo atsaku?',
      'Kiek dabar tikite anksčiau aprašytomis automatinėmis mintimis?',
      'Kokias emocijas jaučiate dabar? Kokio intensyvumo yra šios emocijos?',
      'Ką dar būtų galima padaryti?'

    ];

    for (int i = 0; i < _journalEntryControllers.length; i++) {
      String entry = _journalEntryControllers[i].text;
      if (entry.isNotEmpty) {
        entryText += '${labels[i]}:\n';
        entryText += '${descriptions[i]}: $entry\n\n';
      }
    }

    //final externalStorage = await getExternalStorageDirectory();
    String dateFormatted1 = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final Directory tempDir = await getTemporaryDirectory();
    //final fileName = 'JournalEntry_$_selectedDate.txt';
    final File file = File('${tempDir.path}/Journal_Entry_$dateFormatted1.txt');
    //final file = await File('${externalStorage.path}/$fileName').create();
    await file.writeAsString(entryText);

    final xFile = XFile(file.path, mimeType: 'text/plain');

    await Share.shareXFiles(
      [xFile],
      text: entryText,
      subject: 'Journal Entry: $dateFormatted1',
    );
  }

  @override
  Widget build(BuildContext context) {
    print('date: $_selectedDate');
    JournalEntry entry = widget.entry;
    return Scaffold(
      appBar: AppBar(
        title: Text('Žurnalo įrašas'),
        actions: [
          /*IconButton(
              onPressed: deleteEntryM,
              icon: Icon(Icons.delete_outline_rounded),
          ),*/
          IconButton(
            onPressed: shareEntryM,
            icon: Icon(Icons.share_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(_selectedDate),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Kaip jaučiatės šiandien?',
                  style: TextStyle(fontSize: 16.0),
                ),
                DropdownButtonFormField(
                  value: entry?.mood ?? _selectedMood,
                  hint: Text('Pasirinkite nuotaiką'),
                  items: moodMap.values
                      .map((mood) => DropdownMenuItem(
                    value: mood.type,
                    child: Text(mood.name),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMood = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Pasirinkite nuotaiką';
                    }
                    return null;
                  },
                ),
                ..._buildJournalEntrySections(),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      JournalEntry newEntry = JournalEntry(
                        date: DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day),
                        mood: _selectedMood,
                        entries: _journalEntryControllers.map((controller) => controller.text).toList(),
                      );
                      if (entry != null) {
                        newEntry.id = entry.id;
                        await DatabaseHelper.instance.updateEntry(newEntry);
                      } else {
                        await DatabaseHelper.instance.insertJournalEntry(newEntry);
                      }
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text('Išsaugoti'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
