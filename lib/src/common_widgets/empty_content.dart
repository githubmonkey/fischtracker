import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key? key,
    this.title = 'Nothing here',
    this.message = 'Add a new item to get started',
    this.error,
  }) : super(key: key);
  final String title;
  final String message;
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          Text(message, style: Theme.of(context).textTheme.titleMedium),
          // TODO: write to log/crashlytics, only display in debug
          if (error != null) ...[
            const SizedBox(height: 32.0),
            Text(
              error.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.red),
            ),
          ]
        ],
      ),
    );
  }
}