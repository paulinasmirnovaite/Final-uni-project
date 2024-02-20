import 'dart:ffi';
import 'ket_info.dart';
import 'package:flutter/material.dart';
import 'journal_entry.dart';
import 'calendar_screen.dart';
import 'meditation_screen.dart'; // add this import statement
import 'db_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'chart_screen.dart';

const MaterialColor sageColor = MaterialColor(
  0xFF8FBF8F,
  <int, Color>{
    50: Color(0xFF8FBF8F),
    100: Color(0xFF8FBF8F),
    200: Color(0xFF8FBF8F),
    300: Color(0xFF8FBF8F),
    400: Color(0xFF8FBF8F),
    500: Color(0xFF8FBF8F),
    600: Color(0xFF8FBF8F),
    700: Color(0xFF8FBF8F),
    800: Color(0xFF8FBF8F),
    900: Color(0xFF8FBF8F),
  },
);

const MaterialColor ivoryColor = MaterialColor(
  0xFFFFFFF0,
  <int, Color>{
    50: Color(0xFFFFFFF7),
    100: Color(0xFFFFFFF0),
    200: Color(0xFFFFFFE9),
    300: Color(0xFFFFFFE2),
    400: Color(0xFFFFFFDB),
    500: Color(0xFFFFFFD4),
    600: Color(0xFFFFFFCD),
    700: Color(0xFFFFFFC6),
    800: Color(0xFFFFFFBF),
    900: Color(0xFFFFFFB8),
  },
);

class CustomTextTheme {
  static final TextTheme data = TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 36.0, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 26.0, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
    bodyMedium: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
  );
}

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'KET gidas',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: sageColor,
        scaffoldBackgroundColor: ivoryColor[300],
        appBarTheme: AppBarTheme(
          color: sageColor,
        ),
        textTheme: GoogleFonts.spectralTextTheme(
          CustomTextTheme.data,
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pinkAccent[100]).copyWith(background: ivoryColor),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('lt'), // Lithuanian
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/journal-entry': (context) => JournalEntryScreen(),
        '/calendar': (context) => CalendarScreen(),
        '/meditations': (context) => MeditationScreen(),
        '/book': (context) => BookPage(),
        '/chartScreen': (context) => ChartScreen(),
        //'/': (context) => MyHomePage(sageColor: sageColor, ivoryColor: ivoryColor),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('KET gidas'),
        backgroundColor: sageColor,
        foregroundColor: ivoryColor,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'KET gidas',
              style: textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(Icons.lightbulb_outline_rounded, color: Colors.grey[700]),
              iconSize: 120,
          ),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              pauseAutoPlayOnTouch: false,
              aspectRatio: 1.0,
              onPageChanged: (index, reason) {},
            ),
            items: [
              Padding(
                padding: EdgeInsets.only(right: 36.0, left: 40.0, top: 40.0),
                child: Text(
                  'Tai kognityvinės elgesio terapijos metodais pagrįsta mobilioji aplikacija',
                  style: textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 36.0, left: 40.0, top: 40.0),
                child: Text(
                  'Šioje programėlėje galite kasdien pildyti minčių žurnalą ir atlikti pratimus',
                  style: textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 36.0, left: 40.0, top: 40.0),
                child: Text(
                  'Įveskite įrašus į kalendorių. Pažinkite save ir supraskite ryšį tarp minčių, elgesio, emocijų ir kūno',
                  style: textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              '',
              style: textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 83,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: sageColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Icon(
                            Icons.calendar_today, color: Colors.grey[700]),
                        onPressed: () {
                          Navigator.pushNamed(context, '/calendar',
                              arguments: DateTime.now());
                        },
                      ),
                    ),
                    SizedBox(
                      width: 83,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: sageColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Icon(Icons.waves, color: Colors.grey[700]),
                        onPressed: () {
                          Navigator.pushNamed(context, '/meditations');
                        },
                      ),
                    ),
                    SizedBox(
                      width: 83,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: sageColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Icon(Icons.book, color: Colors.grey[700]),
                        onPressed: () {
                          Navigator.pushNamed(context, '/book');
                        },
                      ),
                    ),
                    SizedBox(
                      width: 83,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: sageColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Icon(Icons.bar_chart_rounded, color: Colors.grey[700]),
                        onPressed: () {
                          Navigator.pushNamed(context, '/chartScreen');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
