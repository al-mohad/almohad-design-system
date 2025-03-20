// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import '../Enums/async_state.dart';
// import 'data/async_data_widget.dart';
// import 'data/async_state_widget.dart';

// /// A custom [Scaffold] widget with built-in support for asynchronous operations.
// ///
// /// This widget provides a customized scaffold that integrates with
// /// asynchronous data loading and state management. It uses the
// /// `AsyncDataWidget` and `AsyncStateWidget` to handle loading states and
// /// refresh/load more functionality.
// ///
// /// The `MyScaffold` widget is designed to be used as a base scaffold for
// /// screens that need to load data asynchronously. It provides a convenient
// /// way to handle loading states, refresh actions, and load more actions.
// ///
// /// See also:
// ///
// ///  * [Scaffold], which is the base class for scaffolds.
// ///  * [AsyncDataWidget], which is used to handle asynchronous data loading.
// ///  * [AsyncStateWidget], which is used to handle asynchronous states.
// class MyScaffold extends StatelessWidget {
//   /// The app bar to display at the top of the scaffold.
//   final PreferredSizeWidget? appBar;

//   /// The main content of the scaffold.
//   final Widget body;

//   /// The alignment of the persistent footer buttons.
//   final AlignmentDirectional persistentFooterAlignment;

//   /// The list of persistent footer buttons to display at the bottom of the
//   /// scaffold.
//   final List<Widget>? persistentFooterButtons;

//   /// The bottom navigation bar to display at the bottom of the scaffold.
//   final Widget? bottomNavigationBar;

//   /// The bottom padding to apply to the scaffold.
//   final double? bottomPadding;

//   /// The asynchronous state of the scaffold.
//   final AsyncState? state;

//   /// The floating action button to display in the scaffold.
//   final Widget? floatingActionButton;

//   /// The scroll controller for the scaffold.
//   final ScrollController? scrollController;

//   /// Creates a [MyScaffold].
//   ///
//   /// The [appBar] parameter is required and represents the app bar to display
//   /// at the top of the scaffold.
//   ///
//   /// The [body] parameter is required and represents the main content of the
//   /// scaffold.
//   ///
//   /// The [onRefresh] parameter is an optional callback that is called when
//   /// the user pulls down to refresh the content.
//   ///
//   /// The [onLoad] parameter is an optional callback that is called when the
//   /// user scrolls to the bottom of the content and more data needs to be
//   /// loaded.
//   ///
//   /// The [hasMore] parameter is an optional boolean that determines whether
//   /// there is more data to load.
//   ///
//   /// The [state] parameter is an optional asynchronous state of the scaffold.
//   ///
//   /// The [persistentFooterAlignment] parameter is an optional alignment for
//   /// the persistent footer buttons.
//   ///
//   /// The [persistentFooterButtons] parameter is an optional list of widgets
//   /// to display as persistent footer buttons.
//   ///
//   /// The [bottomPadding] parameter is an optional double that specifies the
//   /// bottom padding to apply to the scaffold.
//   ///
//   /// The [bottomNavigationBar] parameter is an optional widget to display as
//   /// the bottom navigation bar.
//   ///
//   /// The [floatingActionButton] parameter is an optional widget to display
//   /// as the floating action button.
//   ///
//   /// The [scrollController] parameter is an optional scroll controller for
//   /// the scaffold.
//   MyScaffold({
//     super.key,
//     required this.appBar,
//     required Widget body,
//     AsyncCallback? onRefresh,
//     AsyncCallback? onLoad,
//     bool hasMore = false,
//     this.state,
//     this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
//     this.persistentFooterButtons,
//     this.bottomPadding,
//     this.bottomNavigationBar,
//     this.floatingActionButton,
//     this.scrollController,
//   }) : body = AsyncDataWidget(
//           onLoad: onLoad,
//           onRefresh: onRefresh,
//           hasMore: hasMore,
//           child: body,
//         );

//   /// Creates a [MyScaffold] with sliver support.
//   ///
//   /// The [appBar] parameter is required and represents the app bar to display
//   /// at the top of the scaffold.
//   ///
//   /// The [slivers] parameter is required and represents the list of slivers
//   /// to display in the scaffold.
//   ///
//   /// The [onRefresh] parameter is an optional callback that is called when
//   /// the user pulls down to refresh the content.
//   ///
//   /// The [onLoad] parameter is an optional callback that is called when the
//   /// user scrolls to the bottom of the content and more data needs to be
//   /// loaded.
//   ///
//   /// The [hasMore] parameter is an optional boolean that determines whether
//   /// there is more data to load.
//   ///
//   /// The [state] parameter is an optional asynchronous state of the scaffold.
//   ///
//   /// The [persistentFooterAlignment] parameter is an optional alignment for
//   /// the persistent footer buttons.
//   ///
//   /// The [persistentFooterButtons] parameter is an optional list of widgets
//   /// to display as persistent footer buttons.
//   ///
//   /// The [bottomPadding] parameter is an optional double that specifies the
//   /// bottom padding to apply to the scaffold.
//   ///
//   /// The [bottomNavigationBar] parameter is an optional widget to display as
//   /// the bottom navigation bar.
//   ///
//   /// The [floatingActionButton] parameter is an optional widget to display
//   /// as the floating action button.
//   ///
//   /// The [scrollController] parameter is an optional scroll controller for
//   /// the scaffold.
//   MyScaffold.sliver({
//     super.key,
//     required Widget appBar,
//     Widget? emptyAsyncWidget,
//     required List<Widget> slivers,
//     this.state,
//     AsyncCallback? onRefresh,
//     AsyncCallback? onLoad,
//     bool? hasMore,
//     this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
//     this.persistentFooterButtons,
//     this.bottomPadding,
//     this.bottomNavigationBar,
//     this.floatingActionButton,
//     this.scrollController,
//   })  : appBar = null,
//         body = _sliverBuilder(
//           appBar,
//           slivers,
//           hasMore: hasMore,
//           bottomPadding: bottomPadding,
//           onLoad: onLoad,
//           onRefresh: onRefresh,
//           state: state,
//           emptyAsyncWidget: emptyAsyncWidget,
//         );

//   /// Builds the sliver content of the scaffold.
//   static Widget _sliverBuilder(
//     Widget appBar,
//     List<Widget> slivers, {
//     AsyncState? state,
//     AsyncCallback? onRefresh,
//     AsyncCallback? onLoad,
//     bool? hasMore,
//     double? bottomPadding,
//     Widget? emptyAsyncWidget,
//   }) {
//     return Builder(builder: (context) {
//       return AsyncStateWidget(
//         asyncState: state,
//         emptyAsyncWidget: emptyAsyncWidget,
//         child: AsyncDataWidget.sliver(
//           onLoad: onLoad,
//           onRefresh: onRefresh,
//           hasMore: hasMore,

//           // scrollController: scrollController,
//           headerSlivers: [
//             appBar,
//           ],
//           slivers: slivers,
//           footerSlivers: [
//             if (bottomPadding case double p)
//               SliverPadding(padding: EdgeInsets.only(bottom: p)),
//             // SliverPadding(
//             //     padding: EdgeInsets.only(bottom: padding.bottom + 16)),
//           ],
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar,
//       body: body,
//       persistentFooterAlignment: persistentFooterAlignment,
//       persistentFooterButtons: persistentFooterButtons,
//       bottomNavigationBar: bottomNavigationBar,
//       floatingActionButton: floatingActionButton,
//     );
//   }
// }
