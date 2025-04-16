import 'package:calendar/core/utils/date_formatter.dart';
import 'package:calendar/features/calendar/data/model/event_model.dart';
import 'package:dio/dio.dart';

class DioSettings {
  final Dio _dio = Dio();

  Future<List<EventModel>> fetchEvents(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final response = await _dio.get(
      'https://test-task-app-alpha.vercel.app/api/test-task',
      queryParameters: {
        'start_date': DateFormatter.format(startDate),
        'end_date': DateFormatter.format(endDate),
      },
    );

    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((json) => EventModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}

