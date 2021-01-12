import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:icebreak/stores/authentication_store.dart';
import 'package:icebreak/stores/create_profile_store.dart';
import 'package:icebreak/ui/screens/question_feed_screen.dart';
import 'package:icebreak/ui/widgets/icebreak_app_bar_basic.dart';
import 'package:icebreak/ui/widgets/rounded_rect_button.dart';
import 'package:provider/provider.dart';

import '../ui_constants.dart';

// TODO: Validate input before creating account
class CreateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<CreateProfileStore>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) {
            if (!store.createdProfile) {
              switch (store.page) {
                case CreateAccountPage.nameBirthdayBio:
                  return _NameBirthdayBio(store);
                case CreateAccountPage.gender:
                  return _GenderPage(store);
                case CreateAccountPage.location:
                  return _Location(store);
                default:
                  return Text("Error: CreateAccountPage enum invalid");
              }
            } else {
              return QuestionFeedScreen();
            }
          },
        ),
      ),
    );
  }
}

class _NameBirthdayBio extends StatelessWidget {
  final CreateProfileStore store;

  _NameBirthdayBio(this.store);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        IcebreakAppBarBasic.defaultAppBarWithTitle(
          text: 'New Account',
          onPress: () => print('Tapped Close'),
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
                  Observer(
                    builder: (_) => TextFormField(
                      decoration: kTextFieldInputDecoration.copyWith(
                        labelText: 'Name',
                      ),
                      initialValue: store.name,
                      onChanged: (value) => store.name = value,
                      style: kHeadlineSixTextStyle,
                      cursorColor: kLightRedColor,
                      autocorrect: false,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            'DOB',
                            style: kLabelTextStyle.copyWith(fontSize: 24.0),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 8,
                            child: Observer(
                              builder: (_) => CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: store.birthday,
                                onDateTimeChanged: (DateTime newDateTime) {
                                  store.birthday = newDateTime;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Observer(
                    builder: (_) => TextFormField(
                      decoration: kTextFieldInputDecoration.copyWith(
                        labelText: 'Bio',
                      ),
                      initialValue: store.bio,
                      onChanged: (value) => store.bio = value,
                      style: kHeadlineSixTextStyle,
                      cursorColor: kLightRedColor,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        RoundedRectButton(
          onPress: () => store.goToPage(CreateAccountPage.gender),
          text: 'Next',
        ),
      ],
    );
  }
}

class _GenderPage extends StatelessWidget {
  final CreateProfileStore store;
  final ageRange = const RangeValues(18, 29);

  _GenderPage(this.store);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IcebreakAppBarBasic(
          icon: Icons.arrow_back_ios_rounded,
          text: 'New Account',
          onPress: () => store.goToPage(CreateAccountPage.nameBirthdayBio),
        ),
        Expanded(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                    child: Text(
                      "I am a...",
                      style: kLabelTextStyle,
                    ),
                  ),
                  Observer(
                    builder: (_) => Column(
                      children: [
                        RadioListTile<Gender>(
                          title: const Text('Man'),
                          value: Gender.male,
                          groupValue: store.gender,
                          onChanged: _setGender,
                        ),
                        RadioListTile<Gender>(
                          title: const Text('Woman'),
                          value: Gender.female,
                          groupValue: store.gender,
                          onChanged: _setGender,
                        ),
                        RadioListTile<Gender>(
                          title: const Text('Non-binary'),
                          value: Gender.nonBinary,
                          groupValue: store.gender,
                          onChanged: _setGender,
                        ),
                        RadioListTile<Gender>(
                          title: const Text('Other'),
                          value: Gender.other,
                          groupValue: store.gender,
                          onChanged: _setGender,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Interested in...",
                      style: kLabelTextStyle,
                    ),
                  ),
                  Observer(
                    builder: (_) => Column(
                      children: [
                        RadioListTile<Gender>(
                          title: const Text('Men'),
                          value: Gender.male,
                          groupValue: store.interestedIn,
                          onChanged: _setInterestedIn,
                        ),
                        RadioListTile<Gender>(
                          title: const Text('Women'),
                          value: Gender.female,
                          groupValue: store.interestedIn,
                          onChanged: _setInterestedIn,
                        ),
                        RadioListTile<Gender>(
                          title: const Text('Non-binary'),
                          value: Gender.nonBinary,
                          groupValue: store.interestedIn,
                          onChanged: _setInterestedIn,
                        ),
                        RadioListTile<Gender>(
                          title: const Text('Other'),
                          value: Gender.other,
                          groupValue: store.interestedIn,
                          onChanged: _setInterestedIn,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Observer(
                      builder: (_) => Text(
                        "Aged: ${store.ageRange.start.round()} - ${store.ageRange.end.round()}",
                        style: kLabelTextStyle,
                      ),
                    ),
                  ),
                  Observer(
                    builder: (_) => RangeSlider(
                      values: store.ageRange,
                      min: 18,
                      max: 69,
                      activeColor: kDarkRedColor,
                      inactiveColor: Colors.grey[300],
                      divisions: 100,
                      onChanged: (range) => store.ageRange = range,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        RoundedRectButton(
          onPress: () => store.goToPage(CreateAccountPage.location),
          text: 'Next',
        ),
      ],
    );
  }

  void _setGender(Gender gender) => store.gender = gender;
  void _setInterestedIn(Gender gender) => store.interestedIn = gender;
}

class _Location extends StatelessWidget {
  final CreateProfileStore store;

  _Location(this.store);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IcebreakAppBarBasic(
          icon: Icons.arrow_back_ios_rounded,
          text: 'New Account',
          onPress: () => store.goToPage(CreateAccountPage.gender),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: RoundedRectButton(
                  onPress: () async {
                    await Geolocator.requestPermission();
                    store.location = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                  },
                  text: 'Get Location',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, bottom: 16.0),
                    child: Observer(
                      builder: (_) => Text(
                        'Match radius: ${store.searchArea.round()} km',
                        style: kLabelTextStyle,
                      ),
                    ),
                  ),
                  Observer(
                    builder: (_) => Slider(
                      value: store.searchArea,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      activeColor: kDarkRedColor,
                      inactiveColor: Colors.grey[300],
                      onChanged: (double value) => store.searchArea = value,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        RoundedRectButton(
          onPress: () {
            final authStore = Provider.of<AuthenticationStore>(
              context,
              listen: false,
            );
            store.createAccount(authStore.token);
          },
          text: 'Submit',
        ),
      ],
    );
  }
}
