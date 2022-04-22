import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerState, ConsumerStatefulWidget, ConsumerWidget, WidgetRef;
import 'package:showcase_demo/_features.dart';
import 'package:showcaseview/showcaseview.dart' show ShowCaseWidget, Showcase;

const kSettingKey = 'settings_key';

/// In this page, we directly want to show the tutorial when it is possible.
/// The [Showcase] widget is displayed only one time.
/// The restore [Icon] allows to clear the key in storage to show again
/// the tutorial at the next open.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static Route<T> route<T>() {
    return MaterialPageRoute(builder: (_) => const SettingsPage());
  }

  Future<void> _writeToStorage(WidgetRef ref) {
    return ref
        .read(storageRef)
        .writeString(key: kSettingKey, value: "completed");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TutorialWrapper(
      builder: (_) => _SettingsView(tutorialContext: _),
      onFinish: () async {
        await _writeToStorage(ref);
      },
    );
  }
}

class _SettingsView extends ConsumerStatefulWidget {
  const _SettingsView({
    Key? key,
    required this.tutorialContext,
  }) : super(key: key);

  final BuildContext tutorialContext;

  @override
  ConsumerState<_SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<_SettingsView> {
  final _oneKey = GlobalKey();

  BuildContext get _tutorialContext => widget.tutorialContext;
  List<GlobalKey> get _tutorialKeys => <GlobalKey>[_oneKey];

  Future<void> _checkTutorial() async {
    final value = await _readFromStorage();
    if (value == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 400), () {
          ShowCaseWidget.of(_tutorialContext)?.startShowCase(_tutorialKeys);
        });
      });
    }
  }

  Future<String?> _readFromStorage() async {
    return ref.read(storageRef).readString(key: kSettingKey);
  }

  Future<void> _clearStorage() async {
    await ref.read(storageRef).remove(key: kSettingKey);
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
        title: const Text('Settings (storage)'),
        actions: <Widget>[
          IconButton(
            onPressed: _clearStorage,
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
