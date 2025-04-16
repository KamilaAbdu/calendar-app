import 'package:calendar/core/theme/app_colors.dart';
import 'package:calendar/core/theme/app_dimens.dart';
import 'package:calendar/core/theme/app_text_styles.dart';
import 'package:calendar/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:calendar/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:calendar/features/calendar/presentation/widgets/date_range_selector.dart';
import 'package:calendar/features/calendar/presentation/widgets/event_list.dart';
import 'package:calendar/features/calendar/presentation/widgets/events_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        centerTitle: false,
        title: Text(
          "Event Calendar".toUpperCase(),
          style: AppTextStyles.s20w600.copyWith(color: Colors.white),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [DateRangeSelector()],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.mediumPadding,
        ),
        child: Column(
          children: [
            SizedBox(height: AppDimens.smallPadding,),
            Expanded(
              child: BlocBuilder<CalendarBloc, CalendarState>(
                builder: (context, state) {
                  if (state is CalendarLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.primaryBlue,
                      ),
                    );
                  } else if (state is CalendarError) {
                    return Center(child: Text(state.message));
                  } else if (state is CalendarLoaded) {
                    return Column(
                      children: [
                        EventsCalendar(
                          focusedDay: focusedDay,
                          selectedDay: selectedDay,
                          events: state.events,
                          onDaySelected: (selected, focused) {
                            setState(() {
                              selectedDay = selected;
                              focusedDay = focused;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: EventList(
                            events: state.events,
                            selectedDay: selectedDay,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text("Select a date range to view events"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
