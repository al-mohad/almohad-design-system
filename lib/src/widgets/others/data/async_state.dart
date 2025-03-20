import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'paginated_providers.dart';

enum AsyncState {
  none,
  loading,
  error,
  empty;

  static bool _isNotNull<T>(T val) => val != null;

  static AsyncState fromPaginationAsyncValue<T>(
    AsyncValue<PaginatedState<T>> v,
  ) {
    return fromAsyncValue(v, (val) => val.list.isNotEmpty);
  }

  static AsyncState fromAsyncValue<T>(
    AsyncValue<T> v, [
    bool Function(T val)? hasData,
  ]) {
    hasData ??= _isNotNull;
    return v.when(
      data: (data) {
        if (hasData!(data)) {
          return AsyncState.none;
        } else {
          return AsyncState.empty;
        }
      },
      error: (error, stackTrace) => AsyncState.error,
      loading: () => AsyncState.loading,
    );
  }

  static AsyncState fromAsyncValueList(AsyncValue<List> v) {
    return v.when(
      data: (data) {
        if (data.isEmpty) {
          return AsyncState.empty;
        } else {
          return AsyncState.none;
        }
      },
      error: (error, stackTrace) => AsyncState.error,
      loading: () => AsyncState.loading,
    );
  }

  static AsyncState fromAsyncSnapshot(AsyncSnapshot snapshot) {
    if (snapshot.hasError) return AsyncState.error;
    if (snapshot.hasData) return AsyncState.none;
    return AsyncState.loading;
  }

  static AsyncState fromAsyncSnapshotList(AsyncSnapshot<List> snapshot) {
    if (snapshot.hasError) return AsyncState.error;
    if (snapshot.hasData) {
      if (snapshot.data!.isEmpty == true) {
        return AsyncState.empty;
      }
      return AsyncState.none;
    }
    return AsyncState.loading;
  }
}
