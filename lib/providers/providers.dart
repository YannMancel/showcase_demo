import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider;
import 'package:showcase_demo/_features.dart';

final storageRef = Provider<StorageInterface>(
  (_) => const LocalStorageBySharedPreferences(),
  name: 'storageRef',
);

final jsonRef = Provider<JsonInterface>(
  (_) => const JsonFromAssets(),
  name: 'jsonRef',
);

final settingsLogicRef = Provider<TutorialLogicInterface>(
  (ref) => SettingsLogic(reader: ref.read),
  name: 'settingsLogicRef',
);
