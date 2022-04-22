import 'package:flutter_riverpod/flutter_riverpod.dart' show Reader;
import 'package:showcase_demo/_features.dart';

class SettingsLogic implements TutorialLogicInterface {
  const SettingsLogic({
    required this.reader,
  });

  final Reader reader;
  static const _kSettingsKey = 'settings_key';

  StorageInterface get _storage => reader(storageRef);

  @override
  Future<void> makeTutorialUnavailable() {
    return _storage.writeString(key: _kSettingsKey, value: "completed");
  }

  @override
  Future<void> clearTutorialCache() async {
    await _storage.remove(key: _kSettingsKey);
  }

  @override
  Future<bool> canDisplayTutorial() async {
    final value = await _storage.readString(key: _kSettingsKey);
    return value == null;
  }
}
