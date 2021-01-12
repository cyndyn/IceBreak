import 'package:flutter/material.dart';
import 'package:icebreak/stores/authentication_store.dart';
import 'package:icebreak/ui/widgets/icebreak_app_bar_basic.dart';
import 'package:icebreak/ui/widgets/rounded_rect_button.dart';
import 'package:provider/provider.dart';

import '../ui_constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode _passwordFocusNode = FocusNode();

  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            IcebreakAppBarBasic.defaultAppBarWithTitle(
              text: 'New Account',
              onPress: () => Navigator.pop(context),
            ),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
                        child: Text(
                          'Welcome',
                          textAlign: TextAlign.center,
                          style: kHeadlineTwoTextStyle,
                        ),
                      ),
                      TextFormField(
                        decoration: kTextFieldInputDecoration.copyWith(
                          labelText: 'Choose a username',
                        ),
                        onChanged: (value) => _username = value,
                        style: kHeadlineSixTextStyle,
                        cursorColor: kLightRedColor,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        focusNode: _passwordFocusNode,
                        decoration: kTextFieldInputDecoration.copyWith(
                          labelText: 'and a password',
                        ),
                        onChanged: (value) => _password = value,
                        style: kHeadlineSixTextStyle,
                        cursorColor: kLightRedColor,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).unfocus(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            RoundedRectButton(
              onPress: () async {
                final authStore = Provider.of<AuthenticationStore>(
                  context,
                  listen: false,
                );
                authStore.register(_username, _password);
                Navigator.pop(context);
              },
              text: 'Register',
            )
          ],
        ),
      ),
    );
  }
}
