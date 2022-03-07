import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';
import 'package:investing_me_io/utils/theme.dart';
import 'package:intl/intl.dart';

class DateDisplayWidget extends StatelessWidget {
  const DateDisplayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(Jiffy().dateTime),
              style: subHeading,
            ),
            Text(
              'Today',
              style: heading,
            )
          ],
        ));
  }
}
