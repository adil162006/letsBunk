import 'package:flutter/material.dart';
import '../controller/summary_controller.dart';

class ThresholdDialog extends StatefulWidget {
  final SummaryController controller;

  const ThresholdDialog({
    super.key,
    required this.controller,
  });

  @override
  State<ThresholdDialog> createState() => _ThresholdDialogState();
}

class _ThresholdDialogState extends State<ThresholdDialog> {
  late double _threshold;

  @override
  void initState() {
    super.initState();
    _threshold = widget.controller.attendanceThreshold;
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: const Color(0xFFF59E0B),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Attendance Threshold',
                  style: TextStyle(
                    color: Color(0xFFF9FAFB),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Set your minimum attendance percentage:',
              style: TextStyle(
                color: const Color(0xFFF9FAFB).withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _threshold,
                    min: 50.0,
                    max: 100.0,
                    divisions: 50,
                    activeColor: const Color(0xFFF59E0B),
                    inactiveColor: const Color(0xFF374151),
                    onChanged: (value) {
                      setState(() {
                        _threshold = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${_threshold.round()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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
                    onPressed: () => _saveThreshold(context),
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
    );
  }

  void _saveThreshold(BuildContext context) {
    widget.controller.updateThreshold(_threshold);
    Navigator.of(context).pop();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Threshold updated to ${_threshold.round()}%'),
        backgroundColor: Colors.green,
      ),
    );
  }
} 