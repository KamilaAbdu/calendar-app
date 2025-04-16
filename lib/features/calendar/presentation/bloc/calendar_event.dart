abstract class CalendarEvent {}

class DateRangeSelectedEvent extends CalendarEvent {
  final DateTime startDate;
  final DateTime endDate;

  DateRangeSelectedEvent({required this.startDate, required this.endDate});
}
