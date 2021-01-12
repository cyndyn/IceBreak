import 'package:flutter/material.dart';
import 'package:icebreak/stores/authentication_store.dart';
import 'package:icebreak/ui/ui_constants.dart';
import 'package:icebreak/ui/widgets/icebreak_app_bar_basic.dart';
import 'package:icebreak/ui/widgets/rounded_rect_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';

  FocusNode _usernameTextFieldFocusNode = FocusNode();
  FocusNode _passwordTextFieldFocusNode = FocusNode();

  void _login() async {
    if (_loginFormKey.currentState.validate()) {
      final authStore = Provider.of<AuthenticationStore>(
        context,
        listen: false,
      );
      authStore.login(_username, _password);
      Navigator.pop(context);
    }
  }

  String _validatorCallback(String value) {
    if (value.length < 3) {
      return 'Must be at least 3 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IcebreakAppBarBasic.defaultAppBarWithTitle(
                text: 'Login',
                onPress: () => Navigator.pop(context),
              ),
              Container(
                margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
                child: Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: kHeadlineTwoTextStyle,
                ),
              ),
              Form(
                key: _loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: kTextFieldInputDecoration.copyWith(
                          labelText: 'Username',
                        ),
                        onChanged: (value) => _username = value,
                        style: kHeadlineSixTextStyle,
                        cursorColor: kLightRedColor,
                        autocorrect: false,
                        autofocus: true,
                        focusNode: _usernameTextFieldFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_passwordTextFieldFocusNode),
                        validator: _validatorCallback,
                      ),
                      TextFormField(
                        decoration: kTextFieldInputDecoration.copyWith(
                          labelText: 'Password',
                        ),
                        onChanged: (value) => _password = value,
                        onFieldSubmitted: (value) => _login(),
                        style: kHeadlineSixTextStyle,
                        cursorColor: kLightRedColor,
                        obscureText: true,
                        focusNode: _passwordTextFieldFocusNode,
                        validator: _validatorCallback,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: RoundedRectButton(
                          onPress: _login,
                          text: 'Login',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
