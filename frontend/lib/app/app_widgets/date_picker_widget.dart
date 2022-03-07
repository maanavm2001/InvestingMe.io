import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:investing_me_io/utils/colors.dart';
import 'package:investing_me_io/utils/theme.dart';

class DatePickerWidget extends StatefulWidget {
  final Function dayUpdateFunction;

  const DatePickerWidget({Key? key, required this.dayUpdateFunction})
      : super(key: key);

  @override
  State<DatePickerWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 15, left: 15),
        child: DatePicker(
          Jiffy().dateTime,
          initialSelectedDate: Jiffy().dateTime,
          height: 85,
          width: 60,
          selectionColor: AppColors.brightGreen,
          selectedTextColor: AppColors.darkGray,
          dateTextStyle: subHeading,
          daysCount: 8,
          dayTextStyle: day,
          onDateChange: (data) => {
            widget.dayUpdateFunction(
                Jiffy(data).yMd.toString().replaceAll('/', '-'))
          },
        ));
  }
}
