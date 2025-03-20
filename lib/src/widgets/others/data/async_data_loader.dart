import 'package:flutter/material.dart';

/// An alternative to FutureBuilder
/// A widget that loads data asynchronously and builds its UI based on the loading state.
///
/// This widget is generic, allowing it to work with any type of data [T].
class AsyncDataLoader<T> extends StatefulWidget {
  /// A function that returns a Future that resolves to the data of type [T].
  final Future<T> Function() load;

  /// A builder function that constructs the UI based on the state of the Future.
  ///
  /// The builder receives the current [BuildContext] and an [AsyncSnapshot] of the data.
  final AsyncWidgetBuilder<T> builder;

  /// Creates an [AsyncDataLoader].
  const AsyncDataLoader({
    super.key,
    required this.load,
    required this.builder,
  });

  @override
  State<AsyncDataLoader<T>> createState() => _AsyncDataLoaderState<T>();
}

/// The private implementation of the [AsyncDataLoader] state.
class _AsyncDataLoaderState<T> extends State<AsyncDataLoader<T>> {
  /// The Future that is used to load the data.
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.load();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: widget.builder,
    );
  }
}