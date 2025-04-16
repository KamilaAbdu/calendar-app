import 'package:calendar/core/theme/app_colors.dart';
import 'package:calendar/core/theme/app_text_styles.dart';
import 'package:calendar/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:calendar/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateRangeSelector extends StatelessWidget {
  const DateRangeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.background),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () async {
        final picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: ThemeData(
                colorScheme: ColorScheme.light(
                  primary: AppColors.primaryBlue,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
                textTheme: const TextTheme(
                  headlineSmall: AppTextStyles.s14w500,
                  titleMedium: AppTextStyles.s14w400,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          final diff = picked.end.difference(picked.start).inDays;
          if (diff < 7) {
            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: const Text("Invalid range"),
                    content: const Text("Range must be at least 7 days."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
            );
          } else {
            context.read<CalendarBloc>().add(
              DateRangeSelectedEvent(
                startDate: picked.start,
                endDate: picked.end,
              ),
            );
          }
        }
      },

      child: const Text(
        "Select Date Range",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
