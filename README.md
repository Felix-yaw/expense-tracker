# expense_tracker

A modern expense-tracking app built with Flutter, using **MVVM** architecture
and a soft light-gray + vivid-orange design language.

## Features

- **Dashboard** — greeting, a staggered summary grid (total spent, daily
  average, budget left with a 7-day sparkline), and recent activity with
  All / This week / This month filters.
- **Expenses** — full list with live search, category filter pills and
  swipe-to-delete.
- **Add expense** — amount, title, category picker, date picker and note, with
  form validation.
- **Statistics** — animated weekly bar chart and a category breakdown donut
  with a legend.
- **Budget** — monthly limit, spend/remaining progress, daily allowance and
  per-category progress bars with an "over budget" state.
- **Profile** — account summary (tracked total, records, categories) and a
  settings list.

## Architecture (MVVM)

```
lib/
  main.dart                     # Provides the repository + MaterialApp
  core/
    theme/                      # AppColors, AppTheme (design tokens)
    utils/formatters.dart       # Currency / date formatting (no intl)
  data/
    models/                     # Expense, ExpenseCategory, Budget
    repositories/               # ExpenseRepository (ChangeNotifier store)
  viewmodels/                   # View-facing state (one per screen)
  navigation/                   # AppRoutes
  views/
    screens/                    # Thin screens; compose feature widgets
    widgets/                    # common/ home/ navigation/
```

- **Model** — `ExpenseRepository` is an in-memory `ChangeNotifier` data source
  seeded with sample data.
- **ViewModel** — `DashboardViewModel`, `ExpensesViewModel`,
  `AddExpenseViewModel`, `StatsViewModel`, `BudgetViewModel`,
  `ProfileViewModel`. Each extends a shared `ViewModel` base that subscribes to
  the repository, so every screen stays in sync.
- **View** — thin screens that read their ViewModel via `provider`
  (`context.watch`) and delegate to small, feature-grouped widgets.

## Getting started

```bash
flutter pub get
flutter run
```

## Quality checks

```bash
flutter analyze   # 0 issues
flutter test      # 8 tests
```
