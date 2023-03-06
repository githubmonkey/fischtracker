import 'dart:async';

import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/cats/presentation/edit_cat_screen/edit_cat_screen_controller.dart';
import 'package:fischtracker/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditCatScreen extends ConsumerStatefulWidget {
  const EditCatScreen({super.key, this.catId, this.cat});

  final CatID? catId;
  final Cat? cat;

  @override
  ConsumerState<EditCatScreen> createState() => _EditCatPageState();
}

class _EditCatPageState extends ConsumerState<EditCatScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _name;

  @override
  void initState() {
    super.initState();
    if (widget.cat != null) {
      _name = widget.cat?.name;
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
          await ref.read(editCatScreenControllerProvider.notifier).submit(
                catID: widget.catId,
                oldCat: widget.cat,
                name: _name ?? '',
              );
      if (success && mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      editCatScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(editCatScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cat == null ? 'New Cat' : 'Edit Cat'),
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
      TextFormField(
        decoration: const InputDecoration(labelText: 'Cat name'),
        keyboardAppearance: Brightness.light,
        initialValue: _name,
        validator: (value) =>
            (value ?? '').isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
      ),
    ];
  }
}
