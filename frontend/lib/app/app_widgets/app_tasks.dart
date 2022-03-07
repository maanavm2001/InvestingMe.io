import 'package:flutter/material.dart';
import 'package:investing_me_io/utils/colors.dart';
import 'package:investing_me_io/utils/theme.dart';

class AppTaskList extends StatefulWidget {
  final Map<String, dynamic> currentDay;

  const AppTaskList({Key? key, required this.currentDay}) : super(key: key);

  @override
  State<AppTaskList> createState() {
    return _AppTaskListState();
  }
}

class _AppTaskListState extends State<AppTaskList> {
  final Map<String, String> _labelDict = {
    'Meditation': 'minutes',
    'Reading': 'pages',
  };
  final EdgeInsets buttonPadding = const EdgeInsets.only(top: 7.5, bottom: 7.5);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Padding(
              padding: buttonPadding,
              child: _taskItem(AppColors.niceBlue, AppColors.mutedNiceBlue,
                  'Meditation', 'meditationFive',
                  length: 5)),
          Padding(
              padding: buttonPadding,
              child: _taskItem(AppColors.niceBlue, AppColors.mutedNiceBlue,
                  'Meditation', 'meditationTen',
                  length: 10)),
          Padding(
              padding: buttonPadding,
              child: _taskItem(AppColors.brightRed, AppColors.mutedBrightRed,
                  'Reading', 'readingFive',
                  length: 5)),
          Padding(
              padding: buttonPadding,
              child: _taskItem(AppColors.brightRed, AppColors.mutedBrightRed,
                  'Reading', 'readingTen',
                  length: 10)),
          // Padding(
          //       padding: buttonPadding,
          //       child: _videoTaskButton(
          //         AppColors.yellow,
          //         AppColors.mutedYellow,
          //         'Video Lessons',
          //         'videoLesson',
          //       ))
        ],
      ),
    );
  }

  _taskItem(Color setColor, Color disabledColor, String buttonDisplayName,
      String activityName,
      {int length = 0}) {
    return GestureDetector(
      onTap: (() => {}),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 30, left: 15, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    buttonDisplayName,
                    style: buttonHeading,
                  ),
                  Text(
                    (length != 0)
                        ? length.toString() +
                            ' ' +
                            _labelDict[buttonDisplayName].toString()
                        : '',
                    style: buttonSubHeading,
                  )
                ],
              ),
            ),
            const Spacer(),
            const VerticalDivider(
                thickness: 2, indent: 10, endIndent: 10, color: Colors.black),
            Transform.rotate(
              angle: 1.5708,
              child: Container(
                  width: 47,
                  child: Text(
                      !widget.currentDay[activityName] &&
                              widget.currentDay['isActive']
                          ? 'TO-DO'
                          : 'DONE',
                      style: smallSubHeading,
                      softWrap: false)),
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: !widget.currentDay[activityName] &&
                    widget.currentDay['isActive']
                ? setColor
                : disabledColor),
      ),
    );
  }
}
