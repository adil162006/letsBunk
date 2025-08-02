import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/timetable_controller.dart';
import '../model/timetable_day_model.dart';
import '../widgets/today_schedule_card.dart';
import '../widgets/day_edit_dialog.dart';
import 'create_timetable_screen.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize timetable when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TimetableController>().initializeTimetable();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        title: const Text(
          'AppSprint',
          style: TextStyle(
            color: Color(0xFFF9FAFB),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1F2937),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _navigateToCreateTimetable(context),
            icon: const Icon(
              Icons.edit,
              color: Color(0xFFF9FAFB),
            ),
          ),
        ],
      ),
      body: Consumer<TimetableController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
              ),
            );
          }

          return Column(
            children: [
              // Today's Schedule Card
              TodayScheduleCard(controller: controller),
              
              // Weekly Timetable
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 100, // Add padding for bottom navigation
                  ),
                  itemCount: controller.timetable.length,
                  itemBuilder: (context, index) {
                    final day = controller.timetable[index];
                    return _buildDayExpansionTile(day, controller);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDayExpansionTile(TimetableDay day, TimetableController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(
              _getDayIcon(day.day),
              color: const Color(0xFFF59E0B),
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              day.day,
              style: const TextStyle(
                color: Color(0xFFF9FAFB),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => _showDayEditDialog(day, controller),
              icon: const Icon(
                Icons.edit,
                color: Color(0xFF93C5FD),
                size: 18,
              ),
            ),
          ],
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (day.subjects.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF374151),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: const Color(0xFF93C5FD),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'No subjects scheduled',
                          style: TextStyle(
                            color: const Color(0xFFF9FAFB).withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    children: day.subjects.asMap().entries.map((entry) {
                      final index = entry.key;
                      final subject = entry.value;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF374151),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Color(0xFFF59E0B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                subject,
                                style: const TextStyle(
                                  color: Color(0xFFF9FAFB),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getDayIcon(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return Icons.calendar_today;
      case 'tuesday':
        return Icons.calendar_today;
      case 'wednesday':
        return Icons.calendar_today;
      case 'thursday':
        return Icons.calendar_today;
      case 'friday':
        return Icons.calendar_today;
      case 'saturday':
        return Icons.weekend;
      case 'sunday':
        return Icons.weekend;
      default:
        return Icons.calendar_today;
    }
  }

  void _showDayEditDialog(TimetableDay day, TimetableController controller) {
    showDialog(
      context: context,
      builder: (context) => DayEditDialog(
        day: day.day,
        currentSubjects: day.subjects,
        controller: controller,
      ),
    );
  }

  void _navigateToCreateTimetable(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateTimetableScreen(),
      ),
    );
  }
} 