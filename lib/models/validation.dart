class Validation {
  final int id;
  final String studentName;
  final String university;
  final int hours;
  final String activity;
  final String avatar;
  final String status;
  final DateTime createdAt;

  Validation({
    required this.id,
    required this.studentName,
    required this.university,
    required this.hours,
    required this.activity,
    required this.avatar,
    required this.status,
    required this.createdAt,
  });

  factory Validation.fromJson(Map<String, dynamic> json) {
    return Validation(
      id: json['id'],
      studentName: json['student_name'],
      university: json['university'],
      hours: json['hours'],
      activity: json['activity'],
      avatar: json['avatar'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
