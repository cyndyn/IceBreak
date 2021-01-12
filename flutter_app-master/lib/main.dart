import 'package:flutter/material.dart';
import 'package:icebreak/stores/authentication_store.dart';
import 'package:icebreak/ui/ui_constants.dart';
import 'package:icebreak/ui/widgets/authentication_widget.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          Provider<AuthenticationStore>(
            create: (_) => AuthenticationStore(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Nunito',
            primaryColor: kOffWhiteColor,
            scaffoldBackgroundColor: kOffWhiteColor,
            accentColor: kDarkRedColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(
              headline1: kHeadlineOneTextStyle,
              headline6: kHeadlineSixTextStyle,
            ),
          ),
          home: AuthenticationWidget(),
        ),
      ),
    );
