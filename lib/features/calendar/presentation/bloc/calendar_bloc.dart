import 'package:calendar/core/service/dio_settings.dart';
import 'package:calendar/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:calendar/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final DioSettings apiService;

  CalendarBloc({required this.apiService}) : super(CalendarInitial()) {
    on<DateRangeSelected>(_onDateRangeSelected);
  }

  Future<void> _onDateRangeSelected(
      DateRangeSelected event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    try {
      final events = await apiService.fetchEvents(
          event.startDate, event.endDate);
      emit(CalendarLoaded(events: events));
    } catch (e) {
      emit(CalendarError(message: e.toString()));
    }
  }
}
