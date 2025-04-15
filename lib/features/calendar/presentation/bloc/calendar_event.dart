abstract class CalendarEvent {}

class DateRangeSelected extends CalendarEvent {
  final DateTime startDate;
  final DateTime endDate;

  DateRangeSelected({required this.startDate, required this.endDate});
}
