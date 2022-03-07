import 'package:flutter/widgets.dart';
import 'package:investing_me_io/utils/colors.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const BaseButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.brightGreen),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(color: AppColors.softWhite),
              textAlign: TextAlign.center,
              textScaleFactor: 1.2,
            ),
          ),
        ));
  }
}
