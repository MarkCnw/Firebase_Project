class Todo {
  final String title;
  final String subtitle;
  final bool isDone;

  Todo({
    this.title = '',
    this.subtitle = '',
    this.isDone = false,
  });

  Todo copyWith({
    String? title,
    String? subtitle,
    bool? isDone,
  }) {
    return Todo(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isDone: isDone ?? this.isDone,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'isDone': isDone,
    };
  }

  @override
  String toString() {
    return '''Todo:{
      title: $title
      subtitle: $subtitle
      isDone: $isDone
    }''';
  }
}
