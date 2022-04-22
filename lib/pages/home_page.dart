import 'package:flutter/material.dart';
import 'package:showcase_demo/_features.dart';

/// In this page, we want to show the tutorial with click on info [Icon].
/// The [TutorialWidget] widgets are displayed at each time.
class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return TutorialWrapper(
      builder: (_) => _HomeView(title: title),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  int _counter = 0;
  final _oneKey = GlobalKey();
  final _twoKey = GlobalKey();

  List<GlobalKey> get _tutorialKeys => <GlobalKey>[_oneKey, _twoKey];

  void _showTutorial() {
    TutorialWrapper.showTutorial(context, globalKeys: _tutorialKeys);
  }

  void _incrementCounter() => setState(() => _counter++);

  void _pushToSettings() => Navigator.push(context, SettingsPage.route<void>());

  void _pushToVisibility() {
    Navigator.push(context, VisibilityPage.route<void>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: _showTutorial,
            icon: const Icon(Icons.info),
          ),
          IconButton(
            onPressed: _pushToSettings,
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: _pushToVisibility,
            icon: const Icon(Icons.visibility),
          ),
        ],
      ),
      body: Center(
        child: TutorialWidget(
          globalKey: _oneKey,
          description: 'Score area',
          showcaseBackgroundColor: Colors.blue,
          textColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: TutorialWidget(
        globalKey: _twoKey,
        description: 'Click here to increment score',
        shapeBorder: const CircleBorder(),
        showcaseBackgroundColor: Colors.red,
        textColor: Colors.white,
        child: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
