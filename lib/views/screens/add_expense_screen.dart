import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/expense_category.dart';
import '../../data/repositories/expense_repository.dart';
import '../../viewmodels/add_expense_viewmodel.dart';

/// Add-expense form screen.
class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddExpenseViewModel>(
      create: (BuildContext ctx) =>
          AddExpenseViewModel(ctx.read<ExpenseRepository>()),
      child: const _AddExpenseView(),
    );
  }
}

class _AddExpenseView extends StatelessWidget {
  const _AddExpenseView();

  Future<void> _pickDate(BuildContext context, AddExpenseViewModel vm) async {
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
          const _Label('Amount'),
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
          const _Label('Title'),
          const SizedBox(height: 8),
          TextField(
            onChanged: vm.setTitle,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(hintText: 'e.g. Grocery run'),
          ),
          const SizedBox(height: 24),
          const _Label('Category'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              for (final ExpenseCategory category in ExpenseCategory.values)
                _CategoryChip(
                  category: category,
                  selected: vm.category == category,
                  onTap: () => vm.setCategory(category),
                ),
            ],
          ),
          const SizedBox(height: 24),
          const _Label('Date'),
          const SizedBox(height: 8),
          _FieldTile(
            icon: Icons.calendar_today_rounded,
            text: Formatters.fullDate(vm.date),
            onTap: () => _pickDate(context, vm),
          ),
          const SizedBox(height: 24),
          const _Label('Note (optional)'),
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

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.inkSecondary,
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final ExpenseCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? category.color : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? category.color : AppColors.cardBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              category.icon,
              size: 16,
              color: selected ? Colors.white : category.color,
            ),
            const SizedBox(width: 8),
            Text(
              category.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldTile extends StatelessWidget {
  const _FieldTile({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.85)),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 18, color: AppColors.inkSecondary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.inkTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
