import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart' show ShowCaseWidget;

class TutorialWrapper extends StatelessWidget {
  const TutorialWrapper({
    Key? key,
    required this.builder,
    this.onFinish,
  }) : super(key: key);

  final WidgetBuilder builder;
  final VoidCallback? onFinish;

  static void showTutorial(
    BuildContext context, {
    required List<GlobalKey> keys,
  }) {
    try {
      ShowCaseWidget.of(context)?.startShowCase(keys);
    } catch (e) {
      if (e.toString() == 'Exception: Please provide ShowCaseView context') {
        throw Exception('Please provide TutorialWrapper context');
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      onFinish: onFinish != null ? () => onFinish?.call() : null,
      builder: Builder(
        builder: (_) => builder(_),
      ),
    );
  }
}
