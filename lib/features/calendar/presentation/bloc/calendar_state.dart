import 'package:calendar/features/calendar/data/model/event_model.dart';

abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final List<EventModel> events;

  CalendarLoaded({required this.events});
}

class CalendarError extends CalendarState {
  final String message;

  CalendarError({required this.message});
}
