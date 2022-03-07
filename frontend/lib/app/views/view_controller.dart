import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:get/get.dart';
import 'package:investing_me_io/app/app_widgets/app_tasks.dart';
import 'package:investing_me_io/app/app_widgets/current_earned_display.dart';
import 'package:investing_me_io/resources/api_request_factory.dart';
import 'package:investing_me_io/resources/theme_resource.dart';
import 'package:investing_me_io/app/app_widgets/button.dart';
import 'package:investing_me_io/app/app_widgets/date_widget.dart';
import 'package:investing_me_io/app/app_widgets/date_picker_widget.dart';
import 'package:investing_me_io/app/views/add_investment_page.dart';

class ViewController extends StatefulWidget {
  const ViewController({Key? key}) : super(key: key);

  @override
  State<ViewController> createState() => _ViewControllerState();
}

class _ViewControllerState extends State<ViewController> {
  final ApiRequest _apiRequest = ApiRequest();
  late bool _loaded;
  String _currDate = Jiffy().yMd.toString().replaceAll('/', '-');
  late Map<String, dynamic> _currDateData;

  @override
  void initState() {
    _loaded = false;
    _getUser();
    _loadDay(_currDate);
    _loaded = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!_loaded)
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: _appBar(),
            body: Column(
              children: [
                _row1(),
                DatePickerWidget(dayUpdateFunction: _loadDay),
                AppTaskList(currentDay: _currDateData),
              ],
            ),
          );
  }

  _row1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const DateDisplayWidget(),
        const Spacer(),
        Container(
            padding: const EdgeInsets.only(right: 15, top: 40),
            child: !_currDateData['isActive']
                ? BaseButton(
                    text: '+ Invest',
                    onTap: () => Get.to(
                        AddInvestmentPage(currDate: _currDateData['date'])))
                : CurrentEarnedDisplayBox(
                    currentDayBalance: _currDateData['currentDayBalance'],
                    currentDayInvenstment:
                        _currDateData['currentDayInvenstment']))
      ],
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
          onTap: () {
            ThemeService().switchTheme();
          },
          child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5.0),
              child: ImageIcon(
                const AssetImage("assets/night-mode.png"),
                size: 40,
                color: Get.isDarkMode
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : Colors.black,
              ))),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 5.0),
            child: ImageIcon(
              const AssetImage("assets/profile-user.png"),
              size: 40,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ))
      ],
    );
  }

  void _getUser() async {
    var response = await _apiRequest.getUser();
    setState(() {});
  }

  void _loadDay(String dateTime) async {
    var response = await _apiRequest.get('day', dateTime, auth: true);
    setState(() {
      _currDate = dateTime;
      _currDateData = jsonDecode(response['date']);
    });
  }
}
