import 'package:flutter_riverpod/flutter_riverpod.dart' show Reader;
import 'package:showcase_demo/_features.dart';

class VisibilityLogic implements TutorialLogicInterface {
  const VisibilityLogic({required this.reader});

  final Reader reader;
  static const _kVisibilityKey = 'visibility_key';

  StorageInterface get _storage => reader(storageRef);
  JsonInterface get json => reader(jsonRef);

  @override
  Future<bool> canDisplayTutorial() async {
    final keysFromJson = await json.readFromJson();
    final value = await _storage.readString(key: _kVisibilityKey);
    return keysFromJson.contains(_kVisibilityKey) && value == null;
  }

  @override
  Future<void> clearTutorialCache() async {
    await _storage.remove(key: _kVisibilityKey);
  }

  @override
  Future<void> makeTutorialUnavailable() {
    return _storage.writeString(key: _kVisibilityKey, value: "completed");
  }
}
