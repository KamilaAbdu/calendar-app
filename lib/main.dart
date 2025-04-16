import 'package:calendar/core/service/dio_settings.dart';
import 'package:calendar/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:calendar/features/calendar/presentation/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => CalendarBloc(apiService: DioSettings()),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalendarScreen(),
    );
  }
}
