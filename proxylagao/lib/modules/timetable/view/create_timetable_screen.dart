import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/timetable_controller.dart';
import '../model/timetable_day_model.dart';

class CreateTimetableScreen extends StatefulWidget {
  const CreateTimetableScreen({super.key});

  @override
  State<CreateTimetableScreen> createState() => _CreateTimetableScreenState();
}

class _CreateTimetableScreenState extends State<CreateTimetableScreen> {
  final List<TextEditingController> _lectureCountControllers = [];
  final List<List<TextEditingController>> _subjectControllers = [];
  final List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final controller = context.read<TimetableController>();
    
    for (int i = 0; i < _days.length; i++) {
      final day = controller.timetable.firstWhere(
        (d) => d.day == _days[i],
        orElse: () => TimetableDay(day: _days[i], subjects: []),
      );
      
      _lectureCountControllers.add(
        TextEditingController(text: day.subjects.length.toString()),
      );
      
      _subjectControllers.add(
        day.subjects.map((subject) => TextEditingController(text: subject)).toList(),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _lectureCountControllers) {
      controller.dispose();
    }
    for (var controllers in _subjectControllers) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void _updateLectureCount(int dayIndex) {
    final count = int.tryParse(_lectureCountControllers[dayIndex].text) ?? 0;
    if (count >= 0 && count != _subjectControllers[dayIndex].length) {
      setState(() {
        if (count > _subjectControllers[dayIndex].length) {
          // Add more subject controllers
          for (int i = _subjectControllers[dayIndex].length; i < count; i++) {
            _subjectControllers[dayIndex].add(TextEditingController());
          }
        } else {
          // Remove subject controllers
          for (int i = _subjectControllers[dayIndex].length - 1; i >= count; i--) {
            _subjectControllers[dayIndex][i].dispose();
          }
          _subjectControllers[dayIndex] = _subjectControllers[dayIndex].take(count).toList();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        title: const Text(
          'Create Timetable',
          style: TextStyle(
            color: Color(0xFFF9FAFB),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1F2937),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFF9FAFB),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveTimetable,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xFFF59E0B),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<TimetableController>(
        builder: (context, controller, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _days.length,
            itemBuilder: (context, index) {
              return _buildDaySection(index, controller);
            },
          );
        },
      ),
    );
  }

  Widget _buildDaySection(int dayIndex, TimetableController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              _getDayIcon(_days[dayIndex]),
              color: const Color(0xFFF59E0B),
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              _days[dayIndex],
              style: const TextStyle(
                color: Color(0xFFF9FAFB),
                fontSize: 16,
                fontWeight: FontWeight.w600,
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
                // Number of Lectures
                TextFormField(
                  controller: _lectureCountControllers[dayIndex],
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Color(0xFFF9FAFB)),
                  decoration: InputDecoration(
                    labelText: 'Number of Lectures',
                    labelStyle: const TextStyle(color: Color(0xFF93C5FD)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF374151)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF374151)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFF59E0B)),
                    ),
                  ),
                  onChanged: (value) => _updateLectureCount(dayIndex),
                ),
                const SizedBox(height: 16),
                
                // Subject Dropdowns
                if (_subjectControllers[dayIndex].isNotEmpty) ...[
                  Text(
                    'Subjects:',
                    style: const TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(_subjectControllers[dayIndex].length, (subjectIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: DropdownButtonFormField<String>(
                        value: _subjectControllers[dayIndex][subjectIndex].text.isEmpty
                            ? null
                            : _subjectControllers[dayIndex][subjectIndex].text,
                        decoration: InputDecoration(
                          labelText: 'Subject ${subjectIndex + 1}',
                          labelStyle: const TextStyle(color: Color(0xFF93C5FD)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFF374151)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFF374151)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFF59E0B)),
                          ),
                        ),
                        dropdownColor: const Color(0xFF1F2937),
                        style: const TextStyle(color: Color(0xFFF9FAFB)),
                        items: [
                          const DropdownMenuItem<String>(
                            value: null,
                            child: Text('Select Subject', style: TextStyle(color: Color(0xFF93C5FD))),
                          ),
                          ...controller.subjectNames.map((subject) {
                            return DropdownMenuItem<String>(
                              value: subject,
                              child: Text(subject, style: const TextStyle(color: Color(0xFFF9FAFB))),
                            );
                          }).toList(),
                        ],
                        onChanged: (value) {
                          _subjectControllers[dayIndex][subjectIndex].text = value ?? '';
                        },
                      ),
                    );
                  }),
                ],
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

  void _saveTimetable() async {
    try {
      final controller = context.read<TimetableController>();
      
      // Update timetable for each day
      for (int i = 0; i < _days.length; i++) {
        final subjects = _subjectControllers[i]
            .map((controller) => controller.text)
            .where((subject) => subject.isNotEmpty)
            .toList();
        
        controller.updateDayTimetable(_days[i], subjects);
      }
      
      // Save to Supabase
      await controller.saveTimetable();
      
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Timetable saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving timetable: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
} 