import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'journal_entry.dart';
import 'db_helper.dart';
import 'mood_type.dart';

class CalendarScreen extends StatefulWidget{
  static const routeName = '/calendar-screen';

  @override
  Future<List<JournalEntry>> getJournalEntryByDate(DateTime date) async {
    List<JournalEntry> entries =
    await DatabaseHelper.instance.getJournalEntryByDate(date);
    return entries;
  }

  CalendarScreen({Key key}) : super(key: key);
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  EventList<Event> _markedDateMap = EventList<Event>(events: {});
  DateTime selectedDate;

  DateTime selDate;
  DateTime get selDateGetter => selDate;

  void updateSelectedDate(DateTime selectedDate)
  {
    setState(() {
      selDate = selectedDate;
    });
  }

  Color _getMoodColor(JournalEntry entry) {
    return moodMap[entry.mood].color;
  }

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() async {
    List<JournalEntry> entries = await DatabaseHelper.instance.getEntries();
    Map<DateTime, List<Event>> markedDatesMap = _getMarkedDatesMap(entries);
    setState(() {
      _markedDateMap = EventList<Event>(
        events: markedDatesMap,
      );
    });
  }

  Map<DateTime, List<Event>> _getMarkedDatesMap(List<JournalEntry> entries) {
    Map<DateTime, List<Event>> markedDatesMap = {};
    for (JournalEntry entry in entries) {
      Event event = Event(
        date: entry.date,
        icon: entry,
      );
      if (markedDatesMap[event.date] == null) {
        markedDatesMap[event.date] = [];
      }
      markedDatesMap[event.date].add(event);
    }
    return markedDatesMap;
  }

  Widget _buildAppBar() {
    return AppBar(
      title: const Text('Kalendorius'),
      centerTitle: true,
    );
  }

  Widget _getEventMarker(Event event) {
    if (event != null && event.date != null) {
      List<Event> events = _markedDateMap.getEvents(event.date);
      JournalEntry entry =
      events != null && events.isNotEmpty ? events[0].icon as JournalEntry : null;
      Mood mood = entry != null ? moodMap[entry.mood] : null;
      return mood != null
          ? Container(
          width: 16.0,
          height: 16.0,
          margin: const EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: mood.color,
          ),
         child: Center(
            child: Text(
              event.date.day.toString(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
       )
    : null;
     }
     return null;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.0),
            const Text(
              'Norėdami pridėti ar peržiūrėti įrašą, pasirinkite datą',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: CalendarCarousel<Event>(
                onDayPressed: (DateTime selectedDate, List<Event> event) async {
                  print('Selected date: $selectedDate');
                  updateSelectedDate(selectedDate);
                  print('Sel date: $selDate');
                  List<JournalEntry> entries =
                      await DatabaseHelper.instance.getJournalEntryByDate(selDate);
                  JournalEntry entry = entries != null && entries.isNotEmpty ? entries.first : null;
                  if (entry != null && entries.isNotEmpty) {
                  Navigator.pushNamed(
                      context, '/journal-entry',
                      arguments: entry

                  ).then((value) {
                      _loadEntries();
                    });
                  } else {
                    Navigator.pushNamed(
                      context, '/journal-entry',
                      arguments: {'selectedDate': selDate, 'event': event},
                    ).then((value) {
                      _loadEntries();
                    });
                  }
                },
                weekendTextStyle: const TextStyle(
                  color: Colors.red,
                ),
                thisMonthDayBorderColor: Colors.grey,
                weekFormat: false,
                todayButtonColor: Colors.grey[350],
                todayBorderColor: Colors.black,
                todayTextStyle: const TextStyle(
                  color: Colors.black,
                ),
                markedDatesMap: _markedDateMap,
                markedDateIconMaxShown: 1,
                markedDateShowIcon: true,
                  markedDateIconBuilder: (event) {
                    return _getEventMarker(event);
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
