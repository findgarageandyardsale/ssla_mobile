class Notice {
  final String id;
  final String title;
  final String content;
  final String category;
  final DateTime date;
  final bool isImportant;
  final String? attachmentUrl;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.date,
    required this.isImportant,
    this.attachmentUrl,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      category: json['category'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      isImportant: json['isImportant'] ?? false,
      attachmentUrl: json['attachmentUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'date': date.toIso8601String(),
      'isImportant': isImportant,
      'attachmentUrl': attachmentUrl,
    };
  }
}
