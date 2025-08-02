import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/summary_controller.dart';
import '../widgets/attendance_summary_card.dart';
import '../widgets/threshold_dialog.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  void initState() {
    super.initState();
    // Load data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SummaryController>().loadAttendanceData();
      context.read<SummaryController>().loadThreshold();
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
            onPressed: () => _showThresholdDialog(context),
            icon: const Icon(
              Icons.settings,
              color: Color(0xFFF9FAFB),
            ),
          ),
        ],
      ),
      body: Consumer<SummaryController>(
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
              // Attendance Summary Card
              AttendanceSummaryCard(controller: controller),
              
              // Additional content can be added here
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: const Color(0xFF93C5FD),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Quick Info',
                            style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        'Current Threshold',
                        '${controller.attendanceThreshold.round()}%',
                        Icons.trending_up,
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        'Status',
                        controller.attendanceStatus,
                        controller.statusIcon,
                        color: controller.statusColor,
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        'Progress',
                        '${controller.attendance.attendedLectures}/${controller.attendance.totalLectures} lectures',
                        Icons.school,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon, {Color? color}) {
    return Row(
      children: [
        Icon(
          icon,
          color: color ?? const Color(0xFF93C5FD),
          size: 18,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFFF9FAFB).withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color ?? const Color(0xFFF9FAFB),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showThresholdDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ThresholdDialog(controller: context.read<SummaryController>()),
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
      currentIndex: 1, // Dashboard is selected
      onTap: (index) {
        // Handle navigation
        if (index == 0) {
          // Navigate to Home
        } else if (index == 2) {
          // Navigate to Timetable
        }
        // index == 1 is current screen (Dashboard)
      },
    );
  }
} 