class Course {
  final String id;
  final String name;
  final String? description;
  final String? duration;
  final String? level;
  final List<String>? subjects;
  final String imageUrl;
  final double? fee;

  Course({
    required this.id,
    required this.name,
    this.description,
    this.duration,
    this.level,
    this.subjects,
    required this.imageUrl,
    this.fee,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? '',
      level: json['level'] ?? '',
      subjects: List<String>.from(json['subjects'] ?? []),
      imageUrl: json['imageUrl'] ?? '',
      fee: (json['fee'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'duration': duration,
      'level': level,
      'subjects': subjects,
      'imageUrl': imageUrl,
      'fee': fee,
    };
  }
}
