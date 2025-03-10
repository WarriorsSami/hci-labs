import 'dart:collection';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:word_counter/ui/app_colors.dart';
import 'package:word_counter/ui/indicator.dart';

class PieChartWidget extends StatefulWidget {
  final HashMap<String, double> wordCount;

  const PieChartWidget({required this.wordCount, super.key});

  @override
  State<StatefulWidget> createState() => PieChartWidgetState();
}

class PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 10,
                  centerSpaceRadius: 110,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                List.generate((widget.wordCount.length / 2).floor(), (i) {
                  final key = widget.wordCount.keys.elementAt(i);
                  return [
                    Indicator(
                      color: AppColors.getColor(key),
                      text: key,
                      isSquare: true,
                    ),
                    const SizedBox(height: 2),
                  ];
                }).expand((element) => element).toList(),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                List.generate((widget.wordCount.length / 2).ceil(), (i) {
                  final offset = (widget.wordCount.length / 2).floor();
                  final key = widget.wordCount.keys.elementAt(i + offset);
                  return [
                    Indicator(
                      color: AppColors.getColor(key),
                      text: key,
                      isSquare: true,
                    ),
                    const SizedBox(height: 2),
                  ];
                }).expand((element) => element).toList(),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.wordCount.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 140.0 : 110.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final text = widget.wordCount.keys.elementAt(i);
      final percentage = widget.wordCount[text]!;

      return PieChartSectionData(
        color: AppColors.getColor(text),
        value: percentage,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      );
    });
  }
}
