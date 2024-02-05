library lazy_builder_widget;

import 'package:flutter/widgets.dart';

class LazyBuilderWidget<T> extends StatefulWidget {
  const LazyBuilderWidget({super.key, required this.builder, required this.selector, required this.buildWhen});
  final T Function(BuildContext context) selector;

  final Widget Function(BuildContext context, T data) builder;

  final bool Function(T prev, T curr) buildWhen;

  @override
  State<LazyBuilderWidget> createState() => _LazyBuilderWidgetState<T>();
}

class _LazyBuilderWidgetState<T> extends State<LazyBuilderWidget<T>> {
  Widget? prevWidget;
  T? prevData;
  bool pendingChange = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    pendingChange = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int buildCount = 0;
    final curr = widget.selector(context);
    final next = prevData == null ? true : widget.buildWhen(prevData as T, curr);
    prevData = curr;
    return Builder(
      builder: (BuildContext context) {
        if (next || buildCount > 0 || !pendingChange) {
          // Create new widget
          prevWidget = widget.builder(context, curr);
        } else {
          // Re-use previous widget
          prevWidget ??= widget.builder(context, curr);
        }
        pendingChange = false;
        buildCount++;
        return prevWidget!;
      },
    );
  }
}