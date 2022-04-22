import 'package:flutter/material.dart';
import 'package:showcase_demo/storage.dart';
import 'package:showcase_demo/tutorial_wrapper.dart';
import 'package:showcaseview/showcaseview.dart' show ShowCaseWidget, Showcase;

const kSettingKey = 'setting_key';

/// In this page, we directly want to show the tutorial when it is possible.
/// The [Showcase] widget is displayed only one time.
/// The restore [Icon] allows to clear the key in storage to show again
/// the tutorial at the next open.
class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  static Route<T> route<T>() {
    return MaterialPageRoute(builder: (_) => const SettingPage());
  }

  @override
  Widget build(BuildContext context) {
    return TutorialWrapper(
      builder: (_) => _SettingView(tutorialContext: _),
      onFinish: () async {
        await const StorageInterface()
            .writeString(key: kSettingKey, value: "completed");
      },
    );
  }
}

class _SettingView extends StatefulWidget {
  const _SettingView({
    Key? key,
    required this.tutorialContext,
  }) : super(key: key);

  final BuildContext tutorialContext;

  @override
  State<_SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<_SettingView> {
  final _oneKey = GlobalKey();

  BuildContext get _tutorialContext => widget.tutorialContext;
  List<GlobalKey> get _tutorialKeys => <GlobalKey>[_oneKey];

  Future<void> _checkTutorial() async {
    final value = await const StorageInterface().readString(key: kSettingKey);
    if (value == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 400), () {
          ShowCaseWidget.of(_tutorialContext)?.startShowCase(_tutorialKeys);
        });
      });
    }
  }

  Future<void> _resetStorage() async {
    await const StorageInterface().remove(key: kSettingKey);
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
        title: const Text('Settings'),
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
          description: 'This is the fake status',
          showcaseBackgroundColor: Colors.yellow,
          textColor: Colors.black,
          overlayPadding: const EdgeInsets.all(8),
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
