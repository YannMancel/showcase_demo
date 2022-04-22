import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerState, ConsumerStatefulWidget, ConsumerWidget, WidgetRef;
import 'package:showcase_demo/_features.dart';

/// In this page, we directly want to show the tutorial when it is possible.
/// The [TutorialWidget] widget is displayed only one time.
/// The restore [Icon] allows to clear the key in storage to show again
/// the tutorial at the next open.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static Route<T> route<T>() {
    return MaterialPageRoute(builder: (_) => const SettingsPage());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TutorialWrapper(
      builder: (_) => const _SettingsView(),
      onFinish: () async {
        await ref.read(settingsLogicRef).makeTutorialUnavailable();
      },
    );
  }
}

class _SettingsView extends ConsumerStatefulWidget {
  const _SettingsView({Key? key}) : super(key: key);

  @override
  ConsumerState<_SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<_SettingsView> {
  final _oneKey = GlobalKey();

  List<GlobalKey> get _tutorialKeys => <GlobalKey>[_oneKey];

  Future<void> _checkDisplayingOfTutorial() async {
    if (await ref.read(settingsLogicRef).canDisplayTutorial()) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 400), () {
          TutorialWrapper.showTutorial(context, globalKeys: _tutorialKeys);
        });
      });
    }
  }

  Future<void> _clearTutorialCache() async {
    await ref.read(settingsLogicRef).clearTutorialCache();
  }

  @override
  void initState() {
    super.initState();
    _checkDisplayingOfTutorial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings (storage)'),
        actions: <Widget>[
          IconButton(
            onPressed: _clearTutorialCache,
            icon: const Icon(Icons.restore),
          ),
        ],
      ),
      body: Center(
        child: TutorialWidget(
          globalKey: _oneKey,
          description: 'This is the fake status',
          showcaseBackgroundColor: Colors.yellow,
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.green,
            alignment: Alignment.center,
            child: const Text('Fake status'),
          ),
        ),
      ),
    );
  }
}
