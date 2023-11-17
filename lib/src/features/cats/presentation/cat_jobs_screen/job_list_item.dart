import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:flutter/material.dart';

class CatListTile extends StatelessWidget {
  const CatListTile({super.key, required this.cat, this.onTap});
  final Cat cat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cat.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class JobListItem extends StatelessWidget {
  const JobListItem({
    super.key,
    required this.job,
    required this.cat,
    this.onTap,
  });

  final Job job;
  final Cat cat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(child: _buildContents(context)),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return ListTile(title: Text(job.name), subtitle: Text(cat.name));
  }
}

class DismissibleJobListItem extends StatelessWidget {
  const DismissibleJobListItem({
    super.key,
    required this.dismissibleKey,
    required this.job,
    required this.cat,
    this.onDismissed,
    this.onTap,
  });

  final Key dismissibleKey;
  final Job job;
  final Cat cat;
  final VoidCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: dismissibleKey,
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed?.call(),
      child: JobListItem(
        job: job,
        cat: cat,
        onTap: onTap,
      ),
    );
  }
}
