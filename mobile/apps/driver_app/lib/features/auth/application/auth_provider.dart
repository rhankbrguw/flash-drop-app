import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_provider.g.dart';

const _storage = FlutterSecureStorage();
const _tokenKey = 'jwt_token';

@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<String?> build() async {
    try {
      return await _storage.read(key: _tokenKey);
    } on PlatformException catch (e) {
      debugPrint("SecureStorage read fallback: ${e.message}");
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    }
  }

  Future<void> login(String token) async {
    state = const AsyncValue.loading();
    try {
      await _storage.write(key: _tokenKey, value: token);
    } on PlatformException catch (e) {
      debugPrint("SecureStorage write fallback: ${e.message}");
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    }
    state = AsyncValue.data(token);
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await _storage.delete(key: _tokenKey);
    } on PlatformException catch (e) {
      debugPrint("SecureStorage delete fallback: ${e.message}");
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
    }
    state = const AsyncValue.data(null);
  }
}
