import 'package:expense_tracker/data/models/expense.dart';
import 'package:expense_tracker/data/models/expense_category.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/viewmodels/add_expense_viewmodel.dart';
import 'package:expense_tracker/viewmodels/budget_viewmodel.dart';
import 'package:expense_tracker/viewmodels/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpenseRepository', () {
    test('adds and removes expenses', () {
      final ExpenseRepository repo = ExpenseRepository(seed: <Expense>[]);
      expect(repo.expenses, isEmpty);

      repo.add(
        Expense(
          id: repo.nextId(),
          title: 'Coffee',
          amount: 4.5,
          category: ExpenseCategory.food,
          date: DateTime.now(),
        ),
      );
      expect(repo.expenses.length, 1);

      repo.remove(repo.expenses.first.id);
      expect(repo.expenses, isEmpty);
    });

    test('notifies listeners on change', () {
      final ExpenseRepository repo = ExpenseRepository(seed: <Expense>[]);
      int notifications = 0;
      repo.addListener(() => notifications++);

      repo.add(
        Expense(
          id: 'x',
          title: 'Test',
          amount: 10,
          category: ExpenseCategory.other,
          date: DateTime.now(),
        ),
      );

      expect(notifications, 1);
    });
  });

  group('AddExpenseViewModel', () {
    test('validates required fields', () {
      final AddExpenseViewModel vm = AddExpenseViewModel(
        ExpenseRepository(seed: <Expense>[]),
      );

      expect(vm.isValid, isFalse);
      vm.setTitle('Lunch');
      expect(vm.isValid, isFalse);
      vm.setAmount('12.50');
      expect(vm.isValid, isTrue);
      expect(vm.parsedAmount, 12.5);
    });

    test('save persists to the repository', () {
      final ExpenseRepository repo = ExpenseRepository(seed: <Expense>[]);
      final AddExpenseViewModel vm = AddExpenseViewModel(repo)
        ..setTitle('Movie')
        ..setAmount('25')
        ..setCategory(ExpenseCategory.entertainment);

      expect(vm.save(), isTrue);
      expect(repo.expenses.length, 1);
      expect(repo.expenses.first.category, ExpenseCategory.entertainment);
    });

    test('does not save an invalid form', () {
      final ExpenseRepository repo = ExpenseRepository(seed: <Expense>[]);
      final AddExpenseViewModel vm = AddExpenseViewModel(repo);
      expect(vm.save(), isFalse);
      expect(repo.expenses, isEmpty);
    });
  });

  group('ViewModels', () {
    test('dashboard exposes derived figures', () {
      final DashboardViewModel vm = DashboardViewModel(ExpenseRepository());
      expect(vm.userName, 'Miranda');
      expect(vm.last7DayTotals.length, 7);
      expect(vm.last7DayLabels.length, 7);
      expect(vm.monthSpent, greaterThanOrEqualTo(0));
    });

    test('budget reports usage against the limit', () {
      final BudgetViewModel vm = BudgetViewModel(ExpenseRepository());
      expect(vm.limit, greaterThan(0));
      expect(vm.usedFraction, inInclusiveRange(0, 1));
      expect(vm.categoryBudgets, isNotEmpty);
    });
  });

  testWidgets('app renders the dashboard and tabs', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ExpenseTrackerApp());
    await tester.pumpAndSettle();

    // Home tab content.
    expect(find.textContaining('Miranda', findRichText: true), findsWidgets);
    expect(find.text('Home'), findsWidgets);

    // Switch to the Stats tab and confirm it renders.
    await tester.tap(find.byIcon(Icons.insights_outlined).first);
    await tester.pumpAndSettle();
    expect(find.text('Statistics'), findsOneWidget);

    expect(tester.takeException(), isNull);
  });
}
