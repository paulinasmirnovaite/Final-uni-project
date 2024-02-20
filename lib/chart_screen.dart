import 'package:bd_paulina_smirnovaite_v1/ket_info.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'db_helper.dart';
import 'journal_entry.dart';
import 'mood_type.dart';

class ChartScreen extends StatefulWidget {

  final List<JournalEntry> entries;

  ChartScreen({this.entries});

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {

  List<JournalEntry> entries = [];

  @override
  void initState() {
    super.initState();
    fetchEntries();
  }

  void fetchEntries() async {
    List<JournalEntry> fetchedEntries = await DatabaseHelper.instance.getEntries();
    setState(() {
      entries = fetchedEntries;
    });
  }


  TextStyle titleTextStyle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  TextStyle subtitleTextStyle = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );

  List<LineChartBarData> _generateMoodData(
      List<JournalEntry> entries,
      DateTime targetMonth,
      List<DateTime> daysInMonth,
      ) {
    List<FlSpot> moodSpots = daysInMonth.map((day) {
      JournalEntry entry = entries.firstWhereOrNull((e) => isSameDay(e.date, day));
      double moodValue = entry != null ? entry.mood.index.toDouble() : 2;
      return FlSpot(day.day.toDouble(), 4 - moodValue);
    }).toList();

    return [
      LineChartBarData(
        spots: moodSpots,
        isCurved: true,
        barWidth: 2,
        colors: [Colors.blue],
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            final mood = entries.firstWhereOrNull(
                  (e) => isSameDay(e.date, daysInMonth[index]),
            )?.mood ??
                MoodType.neutral;
            final color = moodMap[mood]?.color ?? Colors.yellow[200];
            return FlDotCirclePainter(
              color: color,
              radius: 5,
            );
          },
        ),
      ),
    ];
  }

  List<DateTime> _generateDaysInMonth(DateTime targetMonth) {
    int daysInMonth = DateTime(targetMonth.year, targetMonth.month + 1, 0).day;
    List<DateTime> days = List.generate(daysInMonth, (index) {
      return DateTime(targetMonth.year, targetMonth.month, index + 1);
    });

    return days;
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          color: color,
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mano savijauta'),
        backgroundColor: sageColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              child: PageView.builder(
                itemBuilder: (context, index) {
                  DateTime targetMonth = DateTime.now().subtract(
                    Duration(days: 30 * index),
                  );
                  List<DateTime> daysInMonth = _generateDaysInMonth(targetMonth);

                  List<LineChartBarData> moodData = _generateMoodData(
                    entries,
                    targetMonth,
                    daysInMonth,
                  );


                  return Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Savijautos grafikas ${targetMonth.month}/${targetMonth.year}',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 40),
                        Container(
                          width:  MediaQuery.of(context).size.width,
                          height: 250,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: LineChart(
                                  LineChartData(
                                    lineBarsData: moodData,
                                    gridData: FlGridData(
                                      show: true,
                                      drawHorizontalLine: true,
                                      drawVerticalLine: false,
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                          color: Colors.grey.withOpacity(0.5),
                                          strokeWidth: 0.5,
                                        );
                                      },
                                    ),
                                    titlesData: FlTitlesData(
                                      bottomTitles: SideTitles(
                                        showTitles: true,
                                        getTextStyles: (context, value) => titleTextStyle,
                                        margin: 10,
                                        getTitles: (value) => value.toInt().toString(),
                                      ),
                                      leftTitles: SideTitles(
                                        showTitles: true,
                                        getTextStyles: (context, value) => subtitleTextStyle,
                                        margin: 12,
                                        getTitles: (value) {
                                          switch (value.toInt()) {
                                            case 0:
                                              return '0';
                                            case 1:
                                              return '1';
                                            case 2:
                                              return '2';
                                            case 3:
                                              return '3';
                                            case 4:
                                              return '4';
                                          }
                                          return '';
                                        },
                                      ),
                                      rightTitles: SideTitles(showTitles: false),
                                      topTitles: SideTitles(showTitles: false),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey, width: 1),
                                        left: BorderSide(color: Colors.grey, width: 1),
                                      ),
                                    ),
                                    minX: 1,
                                    maxX: daysInMonth.length.toDouble(),
                                    minY: 0,
                                    maxY: 4,
                                    lineTouchData: LineTouchData(
                                      enabled: true,
                                      touchTooltipData: LineTouchTooltipData(
                                        tooltipBgColor: Colors.blueAccent,
                                        getTooltipItems: (touchedSpots) {
                                          return touchedSpots.map((touchedSpot) {
                                            final value = touchedSpot.y;
                                            return LineTooltipItem(
                                              'Savijauta: ${value.toInt()}\nDiena: ${touchedSpot.x.toInt()}',
                                              TextStyle(color: Colors.white),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16,
                            runSpacing: 8,
                            children: [
                              _buildLegendItem(Colors.lime[400], 'Labai gerai'),
                              _buildLegendItem(Colors.lightGreen[400], 'Gerai'),
                              _buildLegendItem(Colors.yellow[200], 'Neutraliai'),
                              _buildLegendItem(Colors.lightBlue[200], 'Blogai'),
                              _buildLegendItem(Colors.blue[400], 'Labai blogai'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}