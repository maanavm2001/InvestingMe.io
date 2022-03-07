import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:investing_me_io/app/app_widgets/button.dart';
import 'package:investing_me_io/resources/api_request_factory.dart';
import 'package:investing_me_io/utils/constants.dart';
import 'package:investing_me_io/utils/local_resources.dart';
import 'package:investing_me_io/utils/colors.dart';
import 'package:investing_me_io/utils/theme.dart';

final _formKey = GlobalKey<FormBuilderState>();

class AddInvestmentPage extends StatefulWidget {
  final String currDate;
  const AddInvestmentPage({Key? key, required this.currDate}) : super(key: key);

  @override
  State<AddInvestmentPage> createState() {
    return _AddInvestmentPageState();
  }
}

class _AddInvestmentPageState extends State<AddInvestmentPage> {
  final ApiRequest _apiRequest = ApiRequest();

  Map<String, dynamic> formData = {
    'range': 1,
    'investmentAmt': 5.00,
  };

  String dateRange = '';
  String oneDay = '';
  List sevenDay = [];
  double? multiplier = oneDayInvstRatio[5.00];

  @override
  void initState() {
    _setDateParams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: Container(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 30, top: 20, right: 30, bottom: 20),
                          child: Column(
                            children: [
                              Text(
                                'Select Investment Length',
                                textAlign: TextAlign.center,
                                style: subHeading,
                              ),
                              FormBuilderChoiceChip(
                                  name: 'choice_chip',
                                  labelStyle: smallSubHeading,
                                  selectedColor: AppColors.brightGreen,
                                  initialValue: 1,
                                  labelPadding: const EdgeInsets.all(10),
                                  alignment: WrapAlignment.center,
                                  elevation: 5,
                                  spacing: 150,
                                  options: const [
                                    FormBuilderFieldOption(
                                        value: 1, child: Text('Today')),
                                    FormBuilderFieldOption(
                                        value: 7, child: Text('7 Days')),
                                  ],
                                  onChanged: (value) =>
                                      {_setValue('range', value)}),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                                left: 30, top: 20, right: 30, bottom: 20),
                            child: Column(children: [
                              Text('Select Investment Amount',
                                  textAlign: TextAlign.center,
                                  style: subHeading),
                              FormBuilderSlider(
                                name: 'slider',
                                min: 1.0,
                                max: 10.0,
                                initialValue: 5.0,
                                divisions: 18,
                                label: r"$",
                                textStyle: heading,
                                minTextStyle: smallSubHeading,
                                maxTextStyle: smallSubHeading,
                                activeColor: AppColors.brightGreen,
                                inactiveColor: AppColors.mutedBrightGreen,
                                onChanged: (value) =>
                                    {_setValue("investmentAmt", value)},
                              ),
                            ])),
                        Container(
                            padding: const EdgeInsets.only(
                                left: 30, top: 20, right: 30, bottom: 20),
                            child: Column(children: [
                              Text(
                                r'You want to invest ' +
                                    formatCurrency
                                        .format(formData["investmentAmt"]) +
                                    ' for ' +
                                    formData['range'].toString() +
                                    ' days?',
                                style: heading,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Total: ' +
                                      formatCurrency.format(
                                          formData["investmentAmt"] *
                                              formData['range']),
                                  style: smallText,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Dates: ' + dateRange,
                                  style: smallText,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Possible Earnings: ' +
                                      formatCurrency.format(
                                          (formData["investmentAmt"] *
                                                  formData['range']) *
                                              multiplier),
                                  style: smallText,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: BaseButton(
                                  onTap: () => _createDays(),
                                  text: 'Make Investment',
                                ),
                              )
                            ]))
                      ],
                    ))
              ],
            )));
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5.0),
              child: ImageIcon(
                const AssetImage("assets/back.png"),
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

  _setValue(String key, var value) {
    setState(() {
      formData[key] = value;

      if (formData['range'] == 1) {
        dateRange = DateFormat.yMMMMd()
            .format(Jiffy(widget.currDate).dateTime)
            .toString();

        multiplier = oneDayInvstRatio[roundDown(formData['investmentAmt']!, 0)];
        formData['dates'] = oneDay;
      } else if (formData['range'] == 7) {
        dateRange = DateFormat.yMMMMd()
                .format(Jiffy(widget.currDate).dateTime)
                .toString() +
            ' - ' +
            DateFormat.yMMMMd()
                .format(Jiffy(widget.currDate).add(days: 6).dateTime)
                .toString();
        multiplier = svnDayInvstRatio[roundDown(formData['investmentAmt']!, 0)];
        formData['dates'] = sevenDay;
      }
    });
  }

  void _createDays() async {
    formData['id'] = id;
    var statusCode =
        await _apiRequest.post('day', 'create', formData, auth: true);
    if (statusCode == 200) {
      Get.back();
    }
  }

  void _setDateParams() {
    oneDay = Jiffy(widget.currDate).yMd.toString().replaceAll('/', '-');
    for (int i = 0; i < 6; i++) {
      sevenDay.add(Jiffy(widget.currDate)
          .add(days: i)
          .yMd
          .toString()
          .replaceAll('/', '-'));
    }
    formData['dates'] = oneDay;
  }
}
