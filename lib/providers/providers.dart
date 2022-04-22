import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider;
import 'package:showcase_demo/_features.dart';

final storageRef = Provider<StorageInterface>(
  (_) => const LocalStorageBySharedPreferences(),
  name: 'storageRef',
);
