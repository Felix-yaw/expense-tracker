import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/expense_category.dart';
import '../../../viewmodels/expenses_viewmodel.dart';
import '../common/empty_state.dart';
import '../common/pill_tab_bar.dart';
import '../home/transaction_tile.dart';

/// The expenses list body: search, category filter and dismissible rows.
class ExpensesView extends StatelessWidget {
  const ExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpensesViewModel vm = context.watch<ExpensesViewModel>();
    final List<Expense> items = vm.visible;

    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: TextField(
              onChanged: vm.setQuery,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'Search expenses…',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.inkTertiary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PillTabBar<ExpenseCategory?>(
              items: <ExpenseCategory?>[null, ...ExpenseCategory.values],
              selected: vm.category,
              labelOf: (ExpenseCategory? c) => c?.label ?? 'All',
              onSelect: vm.setCategory,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
            child: Row(
              children: <Widget>[
                Text(
                  '${items.length} records',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.inkSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  Formatters.currency(vm.visibleTotal),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const EmptyState(
                    icon: Icons.receipt_long_rounded,
                    title: 'No expenses found',
                    message: 'Try a different search or category filter.',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 4),
                    itemBuilder: (BuildContext context, int index) {
                      final Expense expense = items[index];
                      return Dismissible(
                        key: ValueKey<String>(expense.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => vm.remove(expense.id),
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.white,
                          ),
                        ),
                        child: TransactionTile(expense: expense),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
