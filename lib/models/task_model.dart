class Task {
  int? id;
  String title;
  DateTime date;
  String priority;
  int status; // 0 - Incomplete, 1 - Complete

  Task({
    this.id,
    required this.title,
    required this.date,
    required this.priority,
    this.status = 0,
  });

  Task.withId({
    required this.id,
    required this.title,
    required this.date,
    required this.priority,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map['id'] as int,
      title: map['title'] as String,
      date: DateTime.parse(map['date'] as String),
      priority: map['priority'] as String,
      status: map['status'] as int,
    );
  }
}
