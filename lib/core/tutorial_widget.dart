import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart' show Showcase;

class TutorialWidget extends StatelessWidget {
  const TutorialWidget({
    Key? key,
    required this.globalKey,
    required this.description,
    this.shapeBorder = const RoundedRectangleBorder(),
    this.showcaseBackgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.overlayPadding = const EdgeInsets.all(8.0),
    required this.child,
  }) : super(key: key);

  final GlobalKey globalKey;
  final String description;
  final ShapeBorder? shapeBorder;
  final Color showcaseBackgroundColor;
  final Color textColor;
  final EdgeInsets overlayPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      description: description,
      shapeBorder: shapeBorder,
      showcaseBackgroundColor: showcaseBackgroundColor,
      textColor: textColor,
      overlayPadding: overlayPadding,
      child: child,
    );
  }
}
