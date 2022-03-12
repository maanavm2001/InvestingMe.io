import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investing_me_io/app/app_widgets/button.dart';
import 'package:investing_me_io/app/views/view_controller.dart';
import 'package:investing_me_io/utils/theme.dart';

class DialogContent extends StatelessWidget {
  final String responseBody;
  const DialogContent(BuildContext context, this.responseBody, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Payment Confirmed',
        style: heading,
      ),
      content: Container(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                  (responseBody == '')
                      ? 'Payment confirmed. Return back to the home page.'
                      : responseBody,
                  style: subHeading))),
      actions: <Widget>[
        BaseButton(
          onTap: () => _returnToMain(),
          text: 'Ok',
        ),
      ],
    );
  }

  _returnToMain() {
    Get.to(const ViewController());
  }
}
