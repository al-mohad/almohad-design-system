// import 'package:easy_refresh/easy_refresh.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_shared/localization.dart';
// import 'package:mobile_shared/src/Utils/date_format_extension.dart';

// /// A widget that enables loading data with refresh and pagination capabilities.
// ///
// /// This widget uses the `easy_refresh` package to provide pull-to-refresh and
// /// load-more functionality. It can be used with both regular widgets and slivers.
// ///
// /// The widget displays a loading indicator while refreshing or loading more data.
// /// It also provides customizable header and footer messages.
// class AsyncDataWidget extends StatelessWidget {
//   /// A callback function that is called when the user pulls to refresh.
//   ///
//   /// If this is null, the refresh functionality is disabled.
//   final AsyncCallback? onRefresh;

//   /// A callback function that is called when the user scrolls to the bottom
//   /// and wants to load more data.
//   ///
//   /// If this is null, the load-more functionality is disabled.
//   final AsyncCallback? onLoad;

//   /// Indicates whether there is more data to load.
//   ///
//   /// If this is true, the load-more functionality is enabled. If this is false
//   /// or null, the load-more functionality is disabled.
//   final bool? hasMore;

//   /// The child widget to display.
//   ///
//   /// This is the main content of the widget, which can be a list, grid, or any
//   /// other widget.
//   final Widget child;

//   /// The position of the loading indicator.
//   ///
//   /// This is an internal property and should not be set directly.
//   final IndicatorPosition _indicatorPosition;

//   /// An optional scroll controller to control the scroll behavior of the child.
//   final ScrollController? scrollController;

//   /// The clip behavior of the widget.
//   ///
//   /// This determines how the widget's content is clipped.
//   final Clip clip;

//   /// Creates an [AsyncDataWidget] for regular widgets.
//   ///
//   /// The [child] parameter is required and represents the widget to display.
//   /// The [onRefresh] and [onLoad] parameters are optional and represent the
//   /// refresh and load-more callbacks. The [hasMore] parameter indicates
//   /// whether there is more data to load. The [scrollController] parameter is an
//   /// optional scroll controller. The [clip] parameter determines how the widget's
//   /// content is clipped.
//   const AsyncDataWidget({
//     super.key,
//     this.onRefresh,
//     this.onLoad,
//     this.hasMore,
//     required this.child,
//     this.scrollController,
//     this.clip = Clip.hardEdge,
//   }) : _indicatorPosition = IndicatorPosition.above;

//   /// Creates an [AsyncDataWidget] for slivers.
//   ///
//   /// The [slivers] parameter is required and represents the list of slivers to
//   /// display. The [headerSlivers] and [footerSlivers] parameters are optional
//   /// and represent the header and footer slivers. The [onRefresh] and [onLoad]
//   /// parameters are optional and represent the refresh and load-more callbacks.
//   /// The [hasMore] parameter indicates whether there is more data to load. The
//   /// [scrollController] parameter is an optional scroll controller. The [clip]
//   /// parameter determines how the widget's content is clipped.
//   AsyncDataWidget.sliver({
//     super.key,
//     this.onRefresh,
//     this.onLoad,
//     this.hasMore,
//     this.scrollController,
//     this.clip = Clip.hardEdge,
//     List<Widget> headerSlivers = const [],
//     required List<Widget> slivers,
//     List<Widget> footerSlivers = const [],
//   })  : _indicatorPosition = IndicatorPosition.locator,
//         child = CustomScrollView(
//           clipBehavior: clip,
//           slivers: [
//             ...headerSlivers,
//             const HeaderLocator.sliver(),
//             ...slivers,
//             const FooterLocator.sliver(),
//             ...footerSlivers,
//           ],
//         );

//   /// Returns the load-more callback function.
//   ///
//   /// This is an internal property and should not be called directly.
//   AsyncValueGetter<IndicatorResult>? get _onLoad {
//     if (onLoad == null) return null;
//     if (hasMore != true) return null;
//     return () => _call(onLoad!);
//   }

//   /// Returns the refresh callback function.
//   ///
//   /// This is an internal property and should not be called directly.
//   AsyncValueGetter<IndicatorResult>? get _onRefresh {
//     if (onRefresh == null) return null;
//     return () => _call(onRefresh!);
//   }

//   /// Calls the provided callback function and returns the result.
//   ///
//   /// This is an internal method and should not be called directly.
//   Future<IndicatorResult> _call(AsyncCallback callback) async {
//     try {
//       await callback();
//       return IndicatorResult.success;
//     } catch (e) {
//       return IndicatorResult.fail;
//     }
//   }

//   /// Builds the classic footer for the refresh and load-more functionality.
//   ///
//   /// This is an internal method and should not be called directly.
//   ClassicFooter buildClassicFooter(BuildContext context) {
//     final t = T.of(context);
//     return ClassicFooter(
//       position: _indicatorPosition,
//       armedText: t.releaseReady,
//       dragText: t.pullToRefresh,
//       failedText: t.failed,
//       messageText: t.lastUpdatedAt,
//       readyText: t.loading,
//       noMoreText: t.noMore,
//       processedText: t.succeeded,
//       processingText: t.loading,
//       messageBuilder: _messageBuilder,
//     );
//   }

//   /// Builds the classic header for the refresh functionality.
//   ///
//   /// This is an internal method and should not be called directly.
//   ClassicHeader buildClassicHeader(BuildContext context) {
//     final t = T.of(context);
//     return ClassicHeader(
//       position: _indicatorPosition,
//       armedText: t.releaseReady,
//       dragText: t.pullToRefresh,
//       failedText: t.failed,
//       messageText: t.lastUpdatedAt,
//       readyText: t.refreshing,
//       noMoreText: t.noMore,
//       processedText: t.succeeded,
//       processingText: t.refreshing,
//       messageBuilder: _messageBuilder,
//     );
//   }

//   /// Builds the message for the header and footer.
//   ///
//   /// This is an internal method and should not be called directly.
//   Widget _messageBuilder(
//     BuildContext context,
//     IndicatorState state,
//     String text,
//     DateTime dateTime,
//   ) {
//     var messageText = T.of(context).lastUpdatedAt;
//     if (messageText.contains('%T')) {
//       var format = context.dateFormat.add_jm().format(dateTime);
//       messageText = messageText.replaceAll("%T", format);
//     }
//     return Padding(
//       padding: const EdgeInsets.only(top: 4),
//       child: Text(
//         messageText,
//         style: Theme.of(context).textTheme.bodySmall,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loadable = onRefresh == null && onLoad == null;
//     if (loadable && _indicatorPosition != IndicatorPosition.locator) {
//       return child;
//     }
//     return EasyRefresh(
//       header: buildClassicHeader(context),
//       footer: buildClassicFooter(context),
//       onRefresh: _onRefresh,
//       onLoad: _onLoad,
//       child: child,
//     );
//   }
// }
