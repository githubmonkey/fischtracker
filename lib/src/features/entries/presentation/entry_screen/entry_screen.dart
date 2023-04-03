import 'dart:async';

import 'package:fischtracker/src/common_widgets/date_time_picker.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/entries/presentation/entry_screen/entry_screen_controller.dart';
import 'package:fischtracker/src/features/jobs/data/jobs_repository.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:fischtracker/src/localization/string_hardcoded.dart';
import 'package:fischtracker/src/utils/async_value_ui.dart';
import 'package:fischtracker/src/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EntryScreen extends ConsumerStatefulWidget {
  const EntryScreen({super.key, this.jobId, this.entryId, this.entry});

  final JobID? jobId;
  final EntryID? entryId;
  final Entry? entry;

  @override
  ConsumerState<EntryScreen> createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryScreen> {
  final _formKey = GlobalKey<FormState>();

  late JobID _jobId;
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late bool _isOngoing;
  late DateTime _endDate;
  late TimeOfDay _endTime;
  late String _comment;

  DateTime get start => DateTime(_startDate.year, _startDate.month,
      _startDate.day, _startTime.hour, _startTime.minute);

  DateTime get end => DateTime(_endDate.year, _endDate.month, _endDate.day,
      _endTime.hour, _endTime.minute);

  @override
  void initState() {
    super.initState();
    _jobId = widget.entry?.jobId ?? widget.jobId!;
    final start = widget.entry?.start ?? DateTime.now();
    _startDate = DateTime(start.year, start.month, start.day);
    _startTime = TimeOfDay.fromDateTime(start);

    _isOngoing = (widget.entry?.start == null || widget.entry?.end == null);

    final end = widget.entry?.end ?? DateTime.now();
    _endDate = DateTime(end.year, end.month, end.day);
    _endTime = TimeOfDay.fromDateTime(end);

    _comment = widget.entry?.comment ?? '';
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      final success =
      await ref.read(entryScreenControllerProvider.notifier).submit(
        entryId: widget.entryId,
        jobId: _jobId,
        start: start,
        end: _isOngoing ? null : end,
        comment: _comment,
      );
      if (success && mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      entryScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entry != null ? 'Edit Entry' : 'New Entry'),
        actions: <Widget>[
          TextButton(
            child: Text(
              widget.entry != null ? 'Update' : 'Create',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            onPressed: () => _submit(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildJobDropdown(),
                const SizedBox(height: 8.0),
                _buildStartDate(),
                const SizedBox(height: 8.0),
                _buildIsOngoing(),
                _buildEndDate(),
                const SizedBox(height: 8.0),
                _buildDuration(),
                const SizedBox(height: 8.0),
                _buildComment(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobDropdown() {
    List<Job> jobs = ref.watch(jobsStreamProvider).value ?? [];
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: 'Job'),
      items: jobs
          .map<DropdownMenuItem<String>>((Job job) =>
              DropdownMenuItem<String>(value: job.id, child: Text(job.fullName)))
          .toList(),
      value: _jobId,
      validator: (value) => (value ?? '').isNotEmpty ? null : 'Not a valid job',
      onChanged: (value) => _jobId = value ?? '',
    );
  }

  Widget _buildStartDate() {
    return DateTimePicker(
      labelText: 'Start',
      selectedDate: _startDate,
      selectedTime: _startTime,
      onSelectedDate: (date) => setState(() => _startDate = date),
      onSelectedTime: (time) => setState(() => _startTime = time),
    );
  }

  Widget _buildIsOngoing() {
    final color = _isOngoing
        ? null
        : Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.38);

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Still Ongoing...".hardcoded,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: color),
        ),
        Switch(
          value: _isOngoing,
          onChanged: (value) => setState(() => _isOngoing = value),
        ),
      ],
    );
  }

  Widget _buildEndDate() {
    return DateTimePicker(
      labelText: 'End',
      selectedDate: _endDate,
      selectedTime: _endTime,
      onSelectedDate:
          _isOngoing ? null : (date) => setState(() => _endDate = date),
      onSelectedTime:
          _isOngoing ? null : (time) => setState(() => _endTime = time),
    );
  }

  Widget _buildDuration() {
    final durationInHours = end.difference(start).inMinutes.toDouble() / 60.0;
    final durationFormatted = Format.hours(durationInHours);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Duration: $durationFormatted',
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildComment() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 200,
      controller: TextEditingController(text: _comment),
      decoration: const InputDecoration(
        labelText: 'Comment',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      keyboardAppearance: Brightness.light,
      style: const TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (comment) => _comment = comment,
    );
  }
}
