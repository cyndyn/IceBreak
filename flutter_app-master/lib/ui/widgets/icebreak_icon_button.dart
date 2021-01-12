import 'package:flutter/material.dart';
import 'package:icebreak/ui/ui_constants.dart';

class IcebreakIconButton extends StatelessWidget {
  IcebreakIconButton(
      {@required this.onPress, @required this.icon, @required this.size});

  final Function onPress;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    // TODO: Shrink button on tap to give impression that button is pressed
    return RawMaterialButton(
      onPressed: onPress,
      child: Icon(
        icon,
        color: kDarkRedColor,
        size: size,
      ),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      constraints: BoxConstraints.tightFor(
        width: size,
        height: size,
      ),
      enableFeedback: true,
    );
  }
}
