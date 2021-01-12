import 'package:flutter/material.dart';
import 'package:icebreak/stores/authentication_store.dart';
import 'package:icebreak/ui/widgets/icebreak_app_bar_basic.dart';
import 'package:provider/provider.dart';

/// TODO: Implement the question feed screen
class QuestionFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthenticationStore>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IcebreakAppBarBasic(
              icon: Icons.logout,
              text: 'Question Feed',
              onPress: authStore.logout,
            ),
          ],
        ),
      ),
    );
  }
}
