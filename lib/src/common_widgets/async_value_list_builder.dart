import 'package:fischtracker/src/common_widgets/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class AsyncValueListBuilder<T> extends StatelessWidget {
  const AsyncValueListBuilder({
    Key? key,
    required this.data,
    required this.itemBuilder,
  }) : super(key: key);
  final AsyncValue<List<T>> data;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (items) => items.isNotEmpty
          ? ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 0.5, color: Colors.white),
              itemBuilder: (context, index) =>
                  itemBuilder(context, items[index]),
            )
          : const EmptyContent(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      ),
    );
  }
}
