// ignore_for_file: deprecated_member_use

import 'package:budgetapp_fl/common/color_extension.dart';
import 'package:budgetapp_fl/common_widget/subscription_cell.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  final Map<DateTime, List<Map<String, dynamic>>> _dayExpenses = {
    DateTime(2025, 7, 22): [
      {
        "name": "Spotify",
        "icon": Icons.music_note,
        "preis": 5.99,
      },
      {
        "name": "Netflix",
        "icon": Icons.movie,
        "preis": 15.00,
      },
      {
        "name": "YouTube Premium",
        "icon": Icons.play_circle_fill,
        "preis": 18.99,
      },
    ],
    DateTime(2025, 7, 23): [
      {
        "name": "YouTube Premium",
        "icon": Icons.play_circle_fill,
        "preis": 18.99,
      },
    ],
    DateTime(2025, 7, 25): [
      {
        "name": "Disney+",
        "icon": Icons.movie,
        "preis": 7.99,
      },
      {
        "name": "HBO Max",
        "icon": Icons.movie,
        "preis": 11.99,
      },
    ],
  };

  List<Map<String, dynamic>> get _selectedExpenses {
    return _dayExpenses[DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: TColor.gray70.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Kalender",
                        style: TextStyle(
                          color: TColor.gray30,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Rechnungen",
                      style: TextStyle(
                        color: TColor.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TableCalendar(
                      firstDay: DateTime.utc(2022, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: TColor.secondaryG,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: TColor.primary10,
                          shape: BoxShape.circle,
                        ),
                        weekendTextStyle: TextStyle(color: TColor.gray30),
                        defaultTextStyle: TextStyle(color: TColor.white),
                      ),
                      headerStyle: HeaderStyle(
                        titleTextStyle: TextStyle(
                          color: TColor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        formatButtonVisible: false,
                        leftChevronIcon: Icon(Icons.chevron_left, color: TColor.white),
                        rightChevronIcon: Icon(Icons.chevron_right, color: TColor.white),
                        titleCentered: true,
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: TColor.gray30),
                        weekendStyle: TextStyle(color: TColor.gray30),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.MMMM().format(_focusedDay),
                        style: TextStyle(
                          color: TColor.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${_selectedExpenses.fold(0.0, (sum, item) => sum + item["preis"]).toStringAsFixed(2)}",
                        style: TextStyle(
                          color: TColor.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd.MM.yyyy').format(_selectedDay),
                        style: TextStyle(
                          color: TColor.gray30,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                          color: TColor.gray30,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Rechnungen für ausgewählten Tag
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: _selectedExpenses.length,
              itemBuilder: (context, index) {
                var sObj = _selectedExpenses[index];
                return SubscriptionCell(
                  sObj: sObj,
                  onPressed: () {},
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
