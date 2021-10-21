class Stadium {
  int? size;
  String name;

  Stadium({
    required this.size,
    required this.name,
  });

  factory Stadium.fromJson(Map<String, dynamic> json) {
    return Stadium(
      size: json['size'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'size': size,
        'name': name,
      };
}
