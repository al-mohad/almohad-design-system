// import 'dart:async';
// import 'dart:collection';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import '../../Enums/async_state.dart';
// import '../../Utils/paginated_providers.dart';

// /// A builder function for the [Paginator] widget.
// ///
// /// This function is used to build the UI based on the current state of the
// /// paginated data.
// ///
// /// The `context` parameter is the build context.
// ///
// /// The `state` parameter is the current asynchronous state of the data.
// ///
// /// The `data` parameter is the current paginated data.
// ///
// /// The `refresh` parameter is a callback function that can be used to
// /// refresh the data.
// typedef PaginatorBuilder<T> = Widget Function(
//     BuildContext context,
//     AsyncState asyncState,
//     PaginatedState<T> data,
//     AsyncCallback refresh,
//     );

// /// A StatefulWidget that handles paginated data loading and display.
// ///
// /// The `Paginator` widget is responsible for loading data in pages,
// /// managing the loading state, and providing a way to refresh the data.
// /// It uses a `PageLoader` to fetch data and a `PaginatorBuilder` to build
// /// the UI based on the current state of the data.
// ///
// /// The `Paginator` widget is designed to be used with lists or grids that
// /// need to display large datasets in a paginated manner.
// ///
// /// See also:
// ///
// ///  * [PageLoader], which is used to fetch data in pages.
// ///  * [PaginatorBuilder], which is used to build the UI based on the current
// ///    state of the data.
// ///  * [PaginatedState], which represents the current state of the paginated
// ///    data.
// class Paginator<T> extends StatefulWidget {
//   /// The page loader used to fetch data in pages.
//   final PageLoader<T> pageLoader;

//   /// The builder function used to build the UI based on the current state
//   /// of the data.
//   final PaginatorBuilder<T> builder;

//   /// Creates a [Paginator] widget.
//   ///
//   /// The [pageLoader] parameter is required and represents the page loader
//   /// used to fetch data in pages.
//   ///
//   /// The [builder] parameter is required and represents the builder function
//   /// used to build the UI based on the current state of the data.
//   const Paginator({
//     super.key,
//     required this.pageLoader,
//     required this.builder,
//   });

//   @override
//   State<Paginator<T>> createState() => _PaginatorState<T>();
// }

// /// The state for the [Paginator] widget.
// class _PaginatorState<T> extends State<Paginator<T>>
//     with AutomaticKeepAliveClientMixin<Paginator<T>> {
//   /// The cursor used to fetch the next page of data.
//   String? _cursor;

//   /// The list of data items.
//   List<T> _list = [];

//   /// Indicates whether there is more data to load.
//   bool _hasMore = false;

//   /// The current asynchronous state of the data.
//   AsyncState state = AsyncState.loading;

//   /// Indicates whether a data loading operation is in progress.
//   bool _isBusy = false;

//   @override
//   void initState() {
//     super.initState();
//     unawaited(_refresh());
//   }

//   /// Refreshes the data by loading the first page.
//   Future<PaginatedState<T>> _refresh() async {
//     if (_isBusy) throw Exception("Multiple calls to load data");
//     try {
//       final p = await _loadNext(fresh: true);
//       setState(() {
//         state = p.list.isEmpty ? AsyncState.empty : AsyncState.none;
//       });
//       return p;
//     } on Exception {
//       setState(() => state = AsyncState.error);
//       rethrow;
//     }
//   }

//   /// Loads the next page of data.
//   ///
//   /// The [fresh] parameter indicates whether to load the first page of data.
//   Future<PaginatedState<T>> _loadNext({bool fresh = false}) async {
//     if (_isBusy) throw Exception("Multiple calls to load data");
//     try {
//       if (fresh) {
//         setState(() => state = AsyncState.loading);
//       }
//       _isBusy = true;
//       var cursor = fresh ? null : _cursor;
//       final pageData = await widget.pageLoader.loader(cursor);
//       final PageData(:list, :nextCursor) = pageData;
//       AsyncState newState = state;
//       if (state == AsyncState.loading) {
//         newState = list.isEmpty ? AsyncState.empty : AsyncState.none;
//       }

//       setState(() {
//         state = newState;
//         _list = [
//           if (!fresh) ..._list,
//           ...list,
//         ];
//         _cursor = nextCursor;
//         _hasMore = nextCursor != null;
//       });
//       return paginatedState;
//     } on Exception {
//       if (state == AsyncState.loading) {
//         setState(() => state == AsyncState.error);
//       }
//       rethrow;
//     } finally {
//       _isBusy = false;
//     }
//   }

//   /// Gets the current paginated state.
//   PaginatedState<T> get paginatedState {
//     return PaginatedState(
//       list: UnmodifiableListView(_list),
//       loadNext: _loadNext,
//       hasMore: _hasMore,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final child = widget.builder(
//       context,
//       state,
//       paginatedState,
//       _refresh,
//     );
//     return child;
//   }

//   @override
//   bool get wantKeepAlive => true;
// }
