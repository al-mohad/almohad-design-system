import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class PageLoader<T> {
  final Future<PageData<T>> Function(String? cursor) loader;

  PageLoader(this.loader);
}


typedef PaginatedProviderFamily<T, Arg> = AsyncNotifierProviderFamily<
    PaginatedFamilyNotifier<T, Arg>, PaginatedState<T>, Arg>;

abstract class PaginatedFamilyNotifier<T, Arg>
    extends FamilyAsyncNotifier<PaginatedState<T>, Arg> {
  @override
  FutureOr<PaginatedState<T>> build(Arg arg) {
    var pageLoader = this.pageLoader(arg);
    return _loadNextPage(pageLoader);
  }

  Future<PaginatedState<T>> _loadNextPage(PageLoader<T> pageLoader,
      [String? cursor, PaginatedState<T>? prev]) async {
    final page = await pageLoader.loader(cursor);
    var nextCursor = page.nextCursor;
    var list = page.list;
    if (prev != null) list.insertAll(0, prev.list);
    return PaginatedState<T>(
      list: UnmodifiableListView(list),
      loadNext: () {
        if (nextCursor == null) future;
        return update((p) => _loadNextPage(pageLoader, nextCursor, p));
      },
      hasMore: nextCursor != null,
    );
  }

  @protected
  PageLoader<T> pageLoader(Arg arg);
}

typedef PaginatedProvider<T>
    = AsyncNotifierProvider<PaginatedNotifier<T>, PaginatedState<T>>;

abstract class PaginatedNotifier<T> extends AsyncNotifier<PaginatedState<T>> {
  @override
  FutureOr<PaginatedState<T>> build() {
    var pageLoader = this.pageLoader();
    return _loadNextPage(pageLoader);
  }

  Future<PaginatedState<T>> _loadNextPage(PageLoader<T> pageLoader,
      [String? cursor, PaginatedState<T>? prev]) async {
    final page = await pageLoader.loader(cursor);
    var nextCursor = page.nextCursor;
    var list = page.list;
    if (prev != null) list.insertAll(0, prev.list);
    return PaginatedState<T>(
      list: UnmodifiableListView(list),
      loadNext: () {
        if (nextCursor == null) future;
        return update((p) => _loadNextPage(pageLoader, nextCursor, p));
      },
      hasMore: nextCursor != null,
    );
  }

  @protected
  PageLoader<T> pageLoader();

}

class PaginatedState<T> {
  final List<T> list;
  final AsyncValueGetter<PaginatedState<T>> loadNext;
  final bool hasMore;

  const PaginatedState({
    required this.list,
    required this.loadNext,
    required this.hasMore,
  });

  @override
  String toString() {
    return 'PaginatedState<$T>{list.length: ${list.length}, hasMore: $hasMore}';
  }
}

class PageData<T> {
  List<T> list;
  String? nextCursor;

  PageData(this.list, this.nextCursor);

  /// create a Page that can not load more data
  PageData.only(this.list):nextCursor=null;
}
