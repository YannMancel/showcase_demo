import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerState, ConsumerStatefulWidget, ConsumerWidget, WidgetRef;
import 'package:showcase_demo/_features.dart';
import 'package:showcaseview/showcaseview.dart' show ShowCaseWidget, Showcase;

const kVisibilityKey = 'visibility_key';

class VisibilityPage extends ConsumerWidget {
  const VisibilityPage({Key? key}) : super(key: key);

  static Route<T> route<T>() {
    return MaterialPageRoute(builder: (_) => const VisibilityPage());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TutorialWrapper(
      builder: (_) => VisibilityView(tutorialContext: _),
      onFinish: () {},
    );
  }
}

class VisibilityView extends ConsumerStatefulWidget {
  const VisibilityView({
    Key? key,
    required this.tutorialContext,
  }) : super(key: key);

  final BuildContext tutorialContext;

  @override
  ConsumerState<VisibilityView> createState() => _VisibilityViewState();
}

class _VisibilityViewState extends ConsumerState<VisibilityView> {
  final _oneKey = GlobalKey();

  BuildContext get _tutorialContext => widget.tutorialContext;
  List<GlobalKey> get _tutorialKeys => <GlobalKey>[_oneKey];

  Future<void> _checkTutorial() async {
    final keys = await _readKeysFromJson();
    if (keys.isNotEmpty) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 400), () {
          ShowCaseWidget.of(_tutorialContext)?.startShowCase(_tutorialKeys);
        });
      });
    }
  }

  Future<List<String>> _readKeysFromJson() => ref.read(jsonRef).readFromJson();

  Future<void> _resetStorage() async {
    await ref.read(storageRef).remove(key: kVisibilityKey);
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
