import 'package:flutter/foundation.dart';

import '../models/budget.dart';
import '../models/expense.dart';
import '../models/expense_category.dart';

/// In-memory data source and single source of truth — the MVVM "Model" layer.
///
/// It is a [ChangeNotifier]; the ViewModels observe it so every screen stays in
/// sync without knowing about each other.
class ExpenseRepository extends ChangeNotifier {
  ExpenseRepository({List<Expense>? seed, Budget? budget})
    : _expenses = List<Expense>.of(seed ?? seedExpenses()),
      _budget = budget ?? seedBudget();

  final List<Expense> _expenses;
  Budget _budget;

  List<Expense> get expenses => List<Expense>.unmodifiable(_expenses);

  Budget get budget => _budget;

  void add(Expense expense) {
    _expenses.insert(0, expense);
    notifyListeners();
  }

  void update(Expense expense) {
    final int index = _expenses.indexWhere((Expense e) => e.id == expense.id);
    if (index < 0) return;
    _expenses[index] = expense;
    notifyListeners();
  }

  void remove(String id) {
    _expenses.removeWhere((Expense e) => e.id == id);
    notifyListeners();
  }

  void setBudget(Budget budget) {
    _budget = budget;
    notifyListeners();
  }

  String nextId() =>
      DateTime.now().microsecondsSinceEpoch.toString();

  // ─────────────────────────────── Seed data ──────────────────────────────

  static Budget seedBudget() {
    return const Budget(
      monthlyLimit: 2500,
      categoryLimits: <ExpenseCategory, double>{
        ExpenseCategory.food: 600,
        ExpenseCategory.transport: 300,
        ExpenseCategory.shopping: 500,
        ExpenseCategory.bills: 450,
        ExpenseCategory.health: 250,
        ExpenseCategory.entertainment: 250,
      },
    );
  }

  static List<Expense> seedExpenses() {
    final DateTime now = DateTime.now();
    DateTime daysAgo(int days, [int hour = 12, int minute = 0]) {
      final DateTime day = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: days));
      return DateTime(day.year, day.month, day.day, hour, minute);
    }

    return <Expense>[
      Expense(
        id: 'e1',
        title: 'Morning coffee',
        amount: 4.5,
        category: ExpenseCategory.food,
        date: daysAgo(0, 8, 15),
      ),
      Expense(
        id: 'e2',
        title: 'Grocery run',
        amount: 86.20,
        category: ExpenseCategory.food,
        date: daysAgo(0, 18, 40),
        note: 'Weekly groceries at the market',
      ),
      Expense(
        id: 'e3',
        title: 'Ride to office',
        amount: 12.0,
        category: ExpenseCategory.transport,
        date: daysAgo(1, 9, 5),
      ),
      Expense(
        id: 'e4',
        title: 'Running shoes',
        amount: 120.0,
        category: ExpenseCategory.shopping,
        date: daysAgo(2, 16, 30),
        note: 'Cloudstep sneakers',
      ),
      Expense(
        id: 'e5',
        title: 'Electricity bill',
        amount: 74.30,
        category: ExpenseCategory.bills,
        date: daysAgo(3, 10, 0),
      ),
      Expense(
        id: 'e6',
        title: 'Cinema night',
        amount: 28.0,
        category: ExpenseCategory.entertainment,
        date: daysAgo(3, 20, 0),
      ),
      Expense(
        id: 'e7',
        title: 'Pharmacy',
        amount: 19.75,
        category: ExpenseCategory.health,
        date: daysAgo(4, 11, 20),
      ),
      Expense(
        id: 'e8',
        title: 'Lunch with team',
        amount: 32.4,
        category: ExpenseCategory.food,
        date: daysAgo(5, 13, 10),
      ),
      Expense(
        id: 'e9',
        title: 'Online course',
        amount: 45.0,
        category: ExpenseCategory.education,
        date: daysAgo(6, 19, 45),
      ),
      Expense(
        id: 'e10',
        title: 'Metro top-up',
        amount: 25.0,
        category: ExpenseCategory.transport,
        date: daysAgo(7, 8, 30),
      ),
      Expense(
        id: 'e11',
        title: 'New headphones',
        amount: 129.99,
        category: ExpenseCategory.shopping,
        date: daysAgo(8, 15, 0),
        note: 'Noise cancelling',
      ),
      Expense(
        id: 'e12',
        title: 'Dinner date',
        amount: 64.8,
        category: ExpenseCategory.food,
        date: daysAgo(9, 20, 15),
      ),
      Expense(
        id: 'e13',
        title: 'Gym membership',
        amount: 40.0,
        category: ExpenseCategory.health,
        date: daysAgo(10, 7, 0),
      ),
      Expense(
        id: 'e14',
        title: 'Streaming subscription',
        amount: 15.99,
        category: ExpenseCategory.entertainment,
        date: daysAgo(12, 6, 0),
      ),
      Expense(
        id: 'e15',
        title: 'Internet bill',
        amount: 55.0,
        category: ExpenseCategory.bills,
        date: daysAgo(14, 10, 0),
      ),
      Expense(
        id: 'e16',
        title: 'Bookstore',
        amount: 38.5,
        category: ExpenseCategory.education,
        date: daysAgo(16, 17, 30),
      ),
      Expense(
        id: 'e17',
        title: 'Taxi home',
        amount: 18.0,
        category: ExpenseCategory.transport,
        date: daysAgo(18, 22, 10),
      ),
      Expense(
        id: 'e18',
        title: 'Winter jacket',
        amount: 95.0,
        category: ExpenseCategory.shopping,
        date: daysAgo(21, 14, 0),
      ),
      Expense(
        id: 'e19',
        title: 'Brunch',
        amount: 27.6,
        category: ExpenseCategory.food,
        date: daysAgo(24, 11, 30),
      ),
      Expense(
        id: 'e20',
        title: 'Dentist',
        amount: 80.0,
        category: ExpenseCategory.health,
        date: daysAgo(27, 9, 0),
      ),
    ];
  }
}
