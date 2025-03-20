import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'async_state.dart';
import 'async_state_widget.dart';

/// A base widget for handling asynchronous data with Riverpod.
abstract class ConsumerAsyncWidget<T> extends ConsumerStatefulWidget {
  const ConsumerAsyncWidget({super.key});

  FutureOr<T> load(ConsumerAsyncWidgetState<T> state);

  @protected
  bool get wantKeepAlive => false;

  @protected
  void didUpdateWidget(covariant ConsumerAsyncWidget<T> oldWidget) {}

  Widget build(ConsumerAsyncWidgetState<T> state);

  @override
  ConsumerState<ConsumerAsyncWidget<T>> createState() =>
      _ConsumerAsyncWidgetState<T>();
}

abstract class ConsumerAsyncWidgetState<T>
    extends ConsumerState<ConsumerAsyncWidget<T>> {
  var _state = AsyncState.none;
  T? _value;
  T? get value => _value;

  Future<void> refresh() async {
    try {
      setState(() => _state = AsyncState.loading);
      T val = await widget.load(this);
      setState(() {
        _value = val;
        _state = AsyncState.none;
      });
    } catch (e) {
      setState(() => _state = AsyncState.error);
    }
  }
}

class _ConsumerAsyncWidgetState<T> extends ConsumerAsyncWidgetState<T>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    unawaited(refresh());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AsyncStateWidget(asyncState: _state, child: widget.build(this));
  }

  @override
  void didUpdateWidget(covariant ConsumerAsyncWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}
