import 'package:flutter/material.dart';
import '../controller/timetable_controller.dart';

class DayEditDialog extends StatefulWidget {
  final String day;
  final List<String> currentSubjects;
  final TimetableController controller;

  const DayEditDialog({
    super.key,
    required this.day,
    required this.currentSubjects,
    required this.controller,
  });

  @override
  State<DayEditDialog> createState() => _DayEditDialogState();
}

class _DayEditDialogState extends State<DayEditDialog> {
  late TextEditingController _lectureCountController;
  late List<String> _subjects;
  late List<TextEditingController> _subjectControllers;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _lectureCountController = TextEditingController(
      text: widget.currentSubjects.length.toString(),
    );
    _subjects = List.from(widget.currentSubjects);
    _initializeSubjectControllers();
  }

  void _initializeSubjectControllers() {
    _subjectControllers = List.generate(
      _subjects.length,
      (index) => TextEditingController(text: _subjects[index]),
    );
  }

  @override
  void dispose() {
    _lectureCountController.dispose();
    for (var controller in _subjectControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateLectureCount() {
    final count = int.tryParse(_lectureCountController.text) ?? 0;
    if (count > 0 && count != _subjects.length) {
      setState(() {
        if (count > _subjects.length) {
          // Add more subjects
          for (int i = _subjects.length; i < count; i++) {
            _subjects.add('');
            _subjectControllers.add(TextEditingController());
          }
        } else {
          // Remove subjects
          _subjects = _subjects.take(count).toList();
          for (int i = _subjectControllers.length - 1; i >= count; i--) {
            _subjectControllers[i].dispose();
          }
          _subjectControllers = _subjectControllers.take(count).toList();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1F2937),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: const Color(0xFFF59E0B),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Edit ${widget.day} Schedule',
                    style: const TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _lectureCountController,
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
                onChanged: (value) => _updateLectureCount(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter number of lectures';
                  }
                  final count = int.tryParse(value);
                  if (count == null || count <= 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Subjects:',
                style: const TextStyle(
                  color: Color(0xFFF9FAFB),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                constraints: const BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _subjects.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: DropdownButtonFormField<String>(
                        value: _subjects[index].isEmpty ? null : _subjects[index],
                        decoration: InputDecoration(
                          labelText: 'Subject ${index + 1}',
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
                          ...widget.controller.subjectNames.map((subject) {
                            return DropdownMenuItem<String>(
                              value: subject,
                              child: Text(subject, style: const TextStyle(color: Color(0xFFF9FAFB))),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _subjects[index] = value ?? '';
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF93C5FD),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _saveChanges(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF59E0B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Filter out empty subjects
      final validSubjects = _subjects.where((subject) => subject.isNotEmpty).toList();
      
      widget.controller.updateDayTimetable(widget.day, validSubjects);
      Navigator.of(context).pop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.day} schedule updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
} 