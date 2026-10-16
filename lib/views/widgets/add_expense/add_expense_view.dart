import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/expense_category.dart';
import '../../../viewmodels/add_expense_viewmodel.dart';
import '../common/field_label.dart';
import 'category_chip.dart';
import 'field_tile.dart';

/// The add-expense form body.
class AddExpenseView extends StatelessWidget {
  const AddExpenseView({super.key});

  Future<void> _pickDate(
    BuildContext context,
    AddExpenseViewModel vm,
  ) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: vm.date,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
      builder: (BuildContext context, Widget? child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.accent),
        ),
        child: child!,
      ),
    );
    if (picked != null) vm.setDate(picked);
  }

  void _save(BuildContext context, AddExpenseViewModel vm) {
    if (!vm.save()) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Expense added')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final AddExpenseViewModel vm = context.watch<AddExpenseViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add expense')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: <Widget>[
          const FieldLabel('Amount'),
          const SizedBox(height: 8),
          TextField(
            onChanged: vm.setAmount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.0,
              color: AppColors.ink,
            ),
            decoration: const InputDecoration(
              hintText: '0.00',
              prefixText: '\$ ',
              prefixStyle: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const FieldLabel('Title'),
          const SizedBox(height: 8),
          TextField(
            onChanged: vm.setTitle,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(hintText: 'e.g. Grocery run'),
          ),
          const SizedBox(height: 24),
          const FieldLabel('Category'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              for (final ExpenseCategory category in ExpenseCategory.values)
                CategoryChip(
                  category: category,
                  selected: vm.category == category,
                  onTap: () => vm.setCategory(category),
                ),
            ],
          ),
          const SizedBox(height: 24),
          const FieldLabel('Date'),
          const SizedBox(height: 8),
          FieldTile(
            icon: Icons.calendar_today_rounded,
            text: Formatters.fullDate(vm.date),
            onTap: () => _pickDate(context, vm),
          ),
          const SizedBox(height: 24),
          const FieldLabel('Note (optional)'),
          const SizedBox(height: 8),
          TextField(
            onChanged: vm.setNote,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(hintText: 'Add a note…'),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: vm.isValid ? () => _save(context, vm) : null,
            child: const Text('Save expense'),
          ),
        ],
      ),
    );
  }
}
