import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/timetable_controller.dart';
import '../widgets/today_schedule_card.dart';
import '../widgets/day_edit_dialog.dart';

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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
      bottomNavigationBar: _buildBottomNavigationBar(),
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
    switch (day) {
      case 'Monday':
        return Icons.monday;
      case 'Tuesday':
        return Icons.tuesday;
      case 'Wednesday':
        return Icons.wednesday;
      case 'Thursday':
        return Icons.thursday;
      case 'Friday':
        return Icons.friday;
      case 'Saturday':
        return Icons.saturday;
      case 'Sunday':
        return Icons.sunday;
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

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF1F2937),
      selectedItemColor: const Color(0xFFF59E0B),
      unselectedItemColor: const Color(0xFF93C5FD),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'Timetable',
        ),
      ],
      currentIndex: 2, // Timetable is selected
      onTap: (index) {
        // Handle navigation
        if (index == 0) {
          // Navigate to Home
        } else if (index == 1) {
          // Navigate to Dashboard
        }
        // index == 2 is current screen (Timetable)
      },
    );
  }
} 