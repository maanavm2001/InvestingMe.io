import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investing_me_io/app/app_widgets/button.dart';
import 'package:investing_me_io/app/views/view_controller.dart';
import 'package:investing_me_io/resources/api_request_factory.dart';
import 'package:investing_me_io/resources/theme_resource.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final ApiRequest _apiRequest = ApiRequest();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          BaseButton(text: '+ Sign Up User', onTap: () => _signUpUser()),
        ],
      ),
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
    );
  }

  _signUpUser() async {
    await _apiRequest.post('user', 'create', {
      "firstName": "Maanav",
      "lastName": "Modi",
      "email": "s@s.com",
    });
    Get.to(const ViewController());
  }
}
