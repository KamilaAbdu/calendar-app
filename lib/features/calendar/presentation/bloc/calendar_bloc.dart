import 'package:calendar/core/service/dio_settings.dart';
import 'package:calendar/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:calendar/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final DioSettings apiService;

  CalendarBloc({required this.apiService}) : super(CalendarInitial()) {
    on<DateRangeSelectedEvent>(_onDateRangeSelected);
  }

  Future<void> _onDateRangeSelected(
    DateRangeSelectedEvent event,
    Emitter<CalendarState> emit,
  ) async {
    emit(CalendarLoading());

    final diff = event.endDate.difference(event.startDate).inDays;
    if (diff < 7) {
      emit(CalendarError(message: 'Date range must be at least 7 days.'));
      return;
    }

    try {
      final events = await apiService.fetchEvents(event.startDate, event.endDate);
      emit(CalendarLoaded(events: events));
    } catch (e) {
      emit(CalendarError(message: e.toString()));
    }
  }
}

