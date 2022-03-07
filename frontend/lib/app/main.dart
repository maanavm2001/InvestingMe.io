import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:investing_me_io/app/views/sign_up.dart';
import 'package:investing_me_io/resources/theme_resource.dart';
import 'package:investing_me_io/utils/local_resources.dart';
import 'package:investing_me_io/app/views/view_controller.dart';
import 'package:investing_me_io/utils/theme.dart';

void main() async {
  await GetStorage.init();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  InvestingMe createState() => InvestingMe();
}

class InvestingMe extends State<App> {
  bool _loggedIn = false;
  @override
  void initState() {
    if (box.read('id') != null) {
      _loggedIn = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!_loggedIn)
        ? GetMaterialApp(
            title: 'InvestingMe.io',
            debugShowCheckedModeBanner: false,
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode: ThemeService().theme,
            home: const SignUp(),
          )
        : GetMaterialApp(
            title: 'InvestingMe.io',
            debugShowCheckedModeBanner: false,
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode: ThemeService().theme,
            home: const ViewController(),
          );
  }
}
