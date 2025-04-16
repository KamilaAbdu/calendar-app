import 'package:calendar/core/theme/app_colors.dart';
import 'package:calendar/core/theme/app_text_styles.dart';
import 'package:calendar/core/utils/date_formatter.dart';
import 'package:calendar/features/calendar/data/model/event_model.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  final List<EventModel> events;
  final DateTime? selectedDay;

  const EventList({super.key, required this.events, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    final filtered =
        events.where((e) {
          if (selectedDay == null || e.date == null) return false;
          final parsedDate = DateFormatter.parse(e.date!);
          return parsedDate.year == selectedDay!.year &&
              parsedDate.month == selectedDay!.month &&
              parsedDate.day == selectedDay!.day;
        }).toList();

    if (filtered.isEmpty) {
      return const Center(
        child: Text(
          "No events for this date",
          style: TextStyle(color: AppColors.textSecondary, fontStyle: FontStyle.italic),
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final e = filtered[index];
        final parsedDate = DateFormatter.parse(e.date!);
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Icon(Icons.event, color: AppColors.primaryBlue),
            title: Text(
              e.eventName ?? '',
              style: AppTextStyles.s16w500,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(e.description ?? ''),
                const SizedBox(height: 4),
                Text(
                  e.date ?? '',
                  style: AppTextStyles.s12w400.copyWith(color: AppColors.textSecondary)
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
