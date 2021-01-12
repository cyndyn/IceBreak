import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icebreak/ui/ui_constants.dart';
import 'package:icebreak/ui/widgets/icebreak_icon_button.dart';

class IcebreakAppBarBasic extends StatelessWidget {
  IcebreakAppBarBasic({this.icon, this.text, this.onPress});

  IcebreakAppBarBasic.defaultAppBarWithTitle({String text, Function onPress})
      : this(icon: FontAwesomeIcons.times, text: text, onPress: onPress);

  final IconData icon;
  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: IcebreakIconButton(
            icon: icon,
            size: 36.0,
            onPress: onPress,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: kHeadlineSixTextStyle.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 56.0,
        ),
      ],
    );
  }
}
