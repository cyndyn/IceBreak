import 'package:flutter/material.dart';
import 'package:icebreak/ui/screens/login_screen.dart';
import 'package:icebreak/ui/screens/register_screen.dart';
import 'package:icebreak/ui/ui_constants.dart';
import 'package:icebreak/ui/widgets/rounded_rect_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'icebreak',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          Column(
            children: <Widget>[
              RoundedRectButton(
                text: 'Get Started',
                onPress: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegisterScreen(),
                    fullscreenDialog: true,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  FlatButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                        fullscreenDialog: true,
                      ),
                    ),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: kDarkRedColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
