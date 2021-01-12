import 'package:flutter/material.dart';
import 'package:icebreak/ui/ui_constants.dart';

class RoundedRectButton extends StatelessWidget {
  RoundedRectButton(
      {@required this.onPress, @required this.text, this.iconData});

  final void Function() onPress;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    // TODO: Shrink button on tap to give impression that button is pressed
    return RawMaterialButton(
      onPressed: onPress,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      enableFeedback: true,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
            colors: [
              kDarkRedColor,
              kLightRedColor,
            ],
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: (iconData == null)
            ? Text(
                text,
                textAlign: TextAlign.center,
                style: kButtonTextStyle,
              )
            : Icon(
                iconData,
                color: Colors.white,
              ),
      ),
    );
  }
}
