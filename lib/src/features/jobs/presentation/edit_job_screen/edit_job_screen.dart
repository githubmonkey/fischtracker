import 'dart:async';

import 'package:fischtracker/src/features/cats/data/cats_repository.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:fischtracker/src/features/jobs/presentation/edit_job_screen/edit_job_screen_controller.dart';
import 'package:fischtracker/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditJobScreen extends ConsumerStatefulWidget {
  const EditJobScreen({super.key, this.catId, this.jobId, this.job});

  final CatID? catId;
  final JobID? jobId;
  final Job? job;

  @override
  ConsumerState<EditJobScreen> createState() => _EditJobPageState();
}

class _EditJobPageState extends ConsumerState<EditJobScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _catid;


  @override
  void initState() {
    super.initState();
    _catid = widget.job?.catId ?? widget.catId;
    if (widget.job != null) {
      assert(widget.job!.catId == widget.catId);
      _name = widget.job?.name;
    }
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
          await ref.read(editJobScreenControllerProvider.notifier).submit(
                jobId: widget.jobId,
                oldJob: widget.job,
                name: _name ?? '',
                catId: _catid ?? '',
              );
      if (success && mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      editJobScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(editJobScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job == null ? 'New Job' : 'Edit Job'),
        actions: <Widget>[
          TextButton(
            onPressed: state.isLoading ? null : _submit,
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      _buildCatDropdown(),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Job name'),
        keyboardAppearance: Brightness.light,
        initialValue: _name,
        validator: (value) =>
            (value ?? '').isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
      ),
    ];
  }

  Widget _buildCatDropdown() {
    List<Cat> cats = ref.watch(catsStreamProvider).value ?? [];
    return DropdownButtonFormField<String>(
      items: cats
          .map<DropdownMenuItem<String>>((Cat cat) =>
          DropdownMenuItem<String>(value: cat.id, child: Text(cat.name)))
          .toList(),
      value: _catid,
      validator: (value) =>
      (value ?? '').isNotEmpty ? null : 'Not a valid category',
      onChanged: (value) => _catid = value,
    );
  }
}
