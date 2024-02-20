import 'package:sqflite/sqflite.dart';
import 'journal_entry.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';
import 'dart:developer';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database _db;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'journal_entry.db');



    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE journal_entries('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'date INTEGER NOT NULL UNIQUE, '
          'mood INTEGER NOT NULL, '
          'entry1 TEXT, '
          'entry2 TEXT, '
          'entry3 TEXT, '
          'entry4 TEXT, '
          'entry5 TEXT, '
          'entry6 TEXT, '
          'entry7 TEXT, '
          'entry8 TEXT, '
          'entry9 TEXT, '
          'entry10 TEXT)',
    );
  }

  Future<int> insertJournalEntry(JournalEntry entry) async {
    final db = await instance.db;
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final existingEntries = await db.query(
      'journal_entries',
      where: 'date = ?',
      whereArgs: [entry.date.millisecondsSinceEpoch],
      limit: 1,
    );
    if (existingEntries.isNotEmpty) {
    final existingEntry = JournalEntry.fromMap(existingEntries.first);
    existingEntry.mood = entry.mood;
    existingEntry.entries = entry.entries;
    return await db.update(
      'journal_entries',
      existingEntry.toMap(),
      where: 'id = ?',
      whereArgs: [existingEntry.id],
    );
    } else {
      return await db.insert('journal_entries', entry.toMap());
    }
  }

  Future<int> updateEntry(JournalEntry entry) async {
    final db = await instance.db;
    return await db.update(
      'journal_entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<int> deleteEntry(int id) async {
      final db = await instance.db;
      final result = await db.delete(
        'journal_entries',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Delete result: $result');
      return result;
  }

  Future<List<JournalEntry>> getEntries() async {
    final db = await instance.db;
    final entriesMap = await db.query('journal_entries');
    return entriesMap.map((entry) => JournalEntry.fromMap(entry)).toList();
  }

  Future<List<JournalEntry>> getJournalEntryByDate(DateTime date) async {
    final db = await instance.db;
    final entriesMap = await db.query(
      'journal_entries',
      where: 'date >= ? AND date <= ?',
      whereArgs: [
        DateTime(date.year, date.month, date.day).millisecondsSinceEpoch,
        DateTime(date.year, date.month, date.day, 23, 59, 59).millisecondsSinceEpoch,
      ],
    );
    print('EntriesMap: $entriesMap');
    List<JournalEntry> entries = entriesMap.map((entry) => JournalEntry.fromMap(entry)).toList();
    print('JournalEntries: ${entries}');
    return entries;
  }
}
