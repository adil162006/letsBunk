import 'screens/attendence/models/subject_model.dart';

class SampleData {
  static List<Subject> subjects = [
    Subject(
      id: '1',
      name: 'Mobile Application Development',
      attendedLectures: 8,
      totalLectures: 10,
    ),
    Subject(
      id: '2',
      name: 'Data Structures & Algorithms',
      attendedLectures: 12,
      totalLectures: 15,
    ),
    Subject(
      id: '3',
      name: 'Database Management Systems',
      attendedLectures: 6,
      totalLectures: 12,
    ),
    Subject(
      id: '4',
      name: 'Software Engineering',
      attendedLectures: 9,
      totalLectures: 11,
    ),
    Subject(
      id: '5',
      name: 'Computer Networks',
      attendedLectures: 5,
      totalLectures: 8,
    ),
    Subject(
      id: '6',
      name: 'Operating Systems',
      attendedLectures: 14,
      totalLectures: 16,
    ),
  ];
}