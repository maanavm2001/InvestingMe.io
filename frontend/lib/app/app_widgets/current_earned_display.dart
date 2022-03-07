import 'package:flutter/cupertino.dart';
import 'package:investing_me_io/utils/theme.dart';

class CurrentEarnedDisplayBox extends StatefulWidget {
  final double currentDayBalance;
  final double currentDayInvenstment;

  const CurrentEarnedDisplayBox(
      {Key? key,
      required this.currentDayBalance,
      required this.currentDayInvenstment})
      : super(key: key);

  @override
  State<CurrentEarnedDisplayBox> createState() {
    return _CurrentEarnedDisplayBoxState();
  }
}

class _CurrentEarnedDisplayBoxState extends State<CurrentEarnedDisplayBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 50,
      child: Text(
        r'$' +
            widget.currentDayBalance.toString() +
            ' / ' +
            widget.currentDayInvenstment.toStringAsFixed(2),
        style: smallHeading,
      ),
    );
  }
}
