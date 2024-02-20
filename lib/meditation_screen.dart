import 'package:bd_paulina_smirnovaite_v1/main.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/source.dart';
import 'dart:async';
import 'db_helper.dart';
import 'event_interface.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class MeditationScreen extends StatefulWidget {

  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pratimai'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 40, 15),
              child: Text(
                'Vienas iš kognityvinės elgesio terapijos elementų - emocijų valdymas.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 50, 60),
              child: Text(
                'Tai atsipalaidavimo, dėmesio, valdomo kvėpavimo pratimų, meditacijos ir kitų technikų taikymas.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20),
              ),
            ),
            //const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MeditationDetailsScreen(
                        header: 'Progresyvioji raumenų relaksacija',
                        description: 'Progresyvioji raumenų relaksacija - tai pratimas, kurio metu lėtai įtempiant ir atpalaiduojant raumenis mažinamas stresas ir nerimas. Ši technika padeda išmokti atsipalaiduoti.',
                        instr: 'Šiam pratimui atlikti skirkite apie 10 minučių. '
                            'Raskite vietą, kur galėtumėte atlikti šį pratimą netrukdomi. '
                            'Atlikdami šį pratimą neprivalote jausti nerimo. Galite jį atlikti ir kai esate ramus.',
                        audioUrl: 'audio/pratimai_01_mix2tylesnis.mp3'
                      ),
                    ),
                  );
                },
              child: Container(
                width: 300,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green[200],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Progresyvioji raumenų relaksacija',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '8 minutės',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MeditationDetailsScreen(
                            header: 'Dėmesingumo lavinimo meditacija',
                            description: 'Dėmesingumo lavinimo meditacija - tai dėmesingu įsisąmoninimu ir sąmoningumu grįstas KET pratimas.',
                            instr: 'Šiam pratimui atlikti skirkite apie 10 minučių. '
                                'Raskite vietą, kur galėtumėte atlikti šį pratimą netrukdomi. '
                                'Atlikdami šį pratimą neprivalote jausti nerimo. Galite jį atlikti ir kai esate ramus.',
                            audioUrl: 'audio/pratimai_nr_2_mix1_01.mp3'
                        ))
                );
              },
              child: Container(
                width: 300,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green[200],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dėmesingumo lavinimo meditacija',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '8 minutės',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeditationDetailsScreen extends StatefulWidget {

  final String header;
  final String description;
  final String instr;
  final String audioUrl;

  MeditationDetailsScreen({
    @required this.header,
    @required this.description,
    @required this.instr,
    @required this.audioUrl,
  });

  @override
  _MeditationDetailsScreenState createState() =>
      _MeditationDetailsScreenState();
}

class _MeditationDetailsScreenState extends State<MeditationDetailsScreen> {

  AudioPlayer _audioPlayer;
  Duration _duration = Duration();
  Duration _position = Duration();
  bool isPlaying = false;


  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    _initializeAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _initializeAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setSourceUrl(widget.audioUrl);
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    _audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.completed) {
        setState(() {
          _position = Duration();
        });
      }
    });
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.header),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.description,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 25),
            Text(
              widget.instr,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.play_circle_fill_rounded),
                  iconSize: 100,
                  onPressed: () async {
                    _audioPlayer.play(AssetSource(widget.audioUrl));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.pause_circle_filled_rounded),
                  iconSize: 100,
                  onPressed: () {
                    _audioPlayer.pause();
                  },
                ),
              ],
            ),
            SizedBox(height: 25),
            Text(
              "${_position.inMinutes}:${_position.inSeconds.remainder(60).toString().padLeft(2, '0')}/${_duration.inMinutes}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.grey,
                  inactiveTrackColor: Colors.grey,
                  thumbColor: Colors.grey,
                  overlayColor: Colors.grey.withOpacity(0.4),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 16.0),
                ),
                child: Slider(
                  value: _position.inMilliseconds.toDouble(),
                  onChanged: (value) {
                    _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                  },
                  min: 0,
                  max: _duration.inMilliseconds.toDouble(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
