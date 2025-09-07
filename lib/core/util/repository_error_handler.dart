import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mood_log_tests/core/util/datastate.dart';

class RepositoryErrorHandler {
  /// Takes a callback and calls it instantly with error catching. If everything
  /// runs smoothly then returns DataSuccess(data);
  /// If any error occurs returns DataFailed(message, error:error)
  ///
  /// If any more error catching is needed this it can be added here to reduce
  /// the effort of adding error catching everywhere else.
  static Future<DataState<T>> call<T>({
    required Future<T> Function() network,
    Future<T?> Function()? getFromLocal,
    Future<void> Function(T)? saveLocal,
    RepositoryCache? cache,
    String? cacheKey,
    required String proxyMessage,
  }) async {
    try {
      T? data;
      if (cache != null) {
        final cachedData = cache.get<T>(cacheKey);
        data = cachedData;
      }
      if (getFromLocal != null) {
        try {
          data ??= await getFromLocal();
        } catch (e) {
          debugPrint("RepositoryErrorHandler<getFromLocal> $e");
        }
      }

      data ??= await network();

      if (data != null && saveLocal != null) {
        saveLocal(data);
      }

      cache?.set(cacheKey, data);
      return DataSuccess(data as T);
    } on SocketException catch (e) {
      return DataFailed(
        "Network Error! Please Check your internet connection.",
        error: e.toString(),
      );
    } catch (e) {
      return DataFailed(proxyMessage, error: e);
    }
  }
}

/// A simple cache to store data temporarily.
/// This is useful for caching data that is frequently accessed
/// and does not change often.
class RepositoryCache {
  /// A simple cache to store data temporarily.
  /// This is useful for caching data that is frequently accessed
  /// and does not change often.
  final Map<String, dynamic> _cache = {};

  /// The duration(Seconds) for which the cache is valid.
  /// After this duration, the cache will be cleared.
  final double _expirationDuration = 300;

  T? get<T>(String? key) {
    if (key == null || !_cache.containsKey(key)) {
      debugPrint('Cache miss for key: $key');
      return null;
    }
    final data = _cache[key];
    final timestamp = _cache["${key}_timestamp"] as int?;
    if (timestamp != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      if (currentTime - timestamp > _expirationDuration * 1000) {
        // Cache expired, remove the entry
        _cache.remove(key);
        _cache.remove("${key}_timestamp");
        debugPrint('Cache expired for key: $key');
        return null;
      }
    }
    if (data is T) {
      return data;
    }
    debugPrint(
      'Cache miss for key: $key, expected type: $T, found type: ${data.runtimeType}',
    );
    return null;
  }

  void set<T>(String? key, T? value) {
    if (key == null || value == null) {
      debugPrint('Cache set failed: key or value is null');
      return;
    }
    _cache[key] = value;
    _cache["${key}_timestamp"] = DateTime.now().millisecondsSinceEpoch;
  }

  void clear() {
    _cache.clear();
  }
}
