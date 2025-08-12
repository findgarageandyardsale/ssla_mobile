class Testimonial {
  final String id;
  final String name;
  final String role;
  final String content;

  Testimonial({
    required this.id,
    required this.name,
    required this.role,
    required this.content,
  });

  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'role': role, 'content': content};
  }
}
