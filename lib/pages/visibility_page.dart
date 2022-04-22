import 'package:flutter/material.dart';
import 'package:showcase_demo/_features.dart';
import 'package:showcaseview/showcaseview.dart' show ShowCaseWidget, Showcase;

class VisibilityPage extends StatelessWidget {
  const VisibilityPage({Key? key}) : super(key: key);

  static Route<T> route<T>() {
    return MaterialPageRoute(builder: (_) => const VisibilityPage());
  }

  @override
  Widget build(BuildContext context) {
    return TutorialWrapper(
      builder: (_) => VisibilityView(tutorialContext: _),
    );
  }
}

class VisibilityView extends StatefulWidget {
  const VisibilityView({
    Key? key,
    required this.tutorialContext,
  }) : super(key: key);

  final BuildContext tutorialContext;

  @override
  State<VisibilityView> createState() => _VisibilityViewState();
}

class _VisibilityViewState extends State<VisibilityView> {
  final _oneKey = GlobalKey();

  BuildContext get _tutorialContext => widget.tutorialContext;
  List<GlobalKey> get _tutorialKeys => <GlobalKey>[_oneKey];

  Future<void> _checkTutorial() async {
    // TODO
  }

  Future<void> _resetStorage() async {
    // TODO
  }

  @override
  void initState() {
    super.initState();
    _checkTutorial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visibility (json + storage)'),
        actions: <Widget>[
          IconButton(
            onPressed: _resetStorage,
            icon: const Icon(Icons.restore),
          ),
        ],
      ),
      body: Center(
        child: Showcase(
          key: _oneKey,
          description: 'This is the Visibility',
          showcaseBackgroundColor: Colors.orange,
          textColor: Colors.black,
          overlayPadding: const EdgeInsets.all(8),
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.red,
            alignment: Alignment.center,
            child: const Text('Visibility'),
          ),
        ),
      ),
    );
  }
}
