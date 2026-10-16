/// Time window for the dashboard's recent-activity filter.
enum PeriodFilter {
  all('All'),
  week('This week'),
  month('This month');

  const PeriodFilter(this.label);

  final String label;
}
