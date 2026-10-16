import '../data/models/expense_category.dart';

/// One slice of the category breakdown donut.
class CategorySlice {
  const CategorySlice({
    required this.category,
    required this.amount,
    required this.fraction,
  });

  final ExpenseCategory category;
  final double amount;
  final double fraction;
}
