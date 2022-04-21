import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

abstract class StorageInterface {
  const factory StorageInterface() = LocalStorageBySharedPreferences;

  Future<bool> writeString({required String key, required String value});

  Future<String?> readString({required String key, String? defaultValue});

  Future<bool> remove({required String key});
}

class LocalStorageBySharedPreferences implements StorageInterface {
  const LocalStorageBySharedPreferences();

  static SharedPreferences? _sharedPreferences;

  FutureOr<SharedPreferences> _getInstance() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    assert(_sharedPreferences != null, '_sharedPreferences must be not null.');
    return _sharedPreferences!;
  }

  @override
  Future<bool> writeString({
    required String key,
    required String value,
  }) async {
    late bool isSuccess;
    try {
      final instance = await _getInstance();
      isSuccess = await instance.setString(key, value);
    } catch (e) {
      isSuccess = false;
    }
    return isSuccess;
  }

  @override
  Future<String?> readString({
    required String key,
    String? defaultValue,
  }) async {
    late String? value;
    try {
      final instance = await _getInstance();
      value = instance.getString(key) ?? defaultValue;
    } catch (e) {
      value = defaultValue;
    }
    return value;
  }

  @override
  Future<bool> remove({required String key}) async {
    late bool isSuccess;
    try {
      final instance = await _getInstance();
      isSuccess = await instance.remove(key);
    } catch (e) {
      isSuccess = false;
    }
    return isSuccess;
  }
}
