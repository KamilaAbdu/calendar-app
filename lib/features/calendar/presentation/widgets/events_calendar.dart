// ignore_for_file: deprecated_member_use

import 'package:calendar/core/theme/app_colors.dart';
import 'package:calendar/core/theme/app_text_styles.dart';
import 'package:calendar/core/utils/date_formatter.dart';
import 'package:calendar/features/calendar/data/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final List<EventModel> events;

  const EventsCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.primaryBlue,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: const TextStyle(color: Colors.white),
        todayTextStyle: TextStyle(color: AppColors.primaryBlue),
      ),

      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: AppTextStyles.s16w500.copyWith(
          color: AppColors.primaryBlue,
        ),
        leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.primaryBlue),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: AppColors.primaryBlue,
        ),
      ),

      firstDay: DateTime(2000),
      lastDay: DateTime(2100),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: onDaySelected,

      eventLoader: (day) {
        return events.where((e) {
          if (e.date == null) return false;
          final parsedDate = DateFormatter.parse(e.date!);
          return parsedDate.year == day.year &&
              parsedDate.month == day.month &&
              parsedDate.day == day.day;
        }).toList();
      },
    );
  }
}
