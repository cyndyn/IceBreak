import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:icebreak/stores/authentication_store.dart';
import 'package:icebreak/stores/create_profile_store.dart';
import 'package:icebreak/ui/screens/create_profile_screen.dart';
import 'package:icebreak/ui/screens/question_feed_screen.dart';
import 'package:icebreak/ui/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'loading_spinner.dart';

class AuthenticationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthenticationStore>(context, listen: false);
    return Observer(builder: (_) {
      switch (authStore.state) {
        case AuthenticationState.authenticating:
          return Scaffold(body: LoadingSpinner());
        case AuthenticationState.authenticated:
          return (authStore.registered)
              ? Provider(
                  create: (_) => CreateProfileStore(),
                  child: CreateProfileScreen(),
                )
              : QuestionFeedScreen();
        default:
          return WelcomeScreen();
      }
    });
  }
}
