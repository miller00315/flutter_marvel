class Filter {
  final int offset;
  final DateTime date;

  const Filter({
    required this.offset,
    required this.date,
  });

  factory Filter.withDate(int offset) {
    return Filter(
      offset: offset,
      date: DateTime.now(),
    );
  }

  String get timestamp => date.toIso8601String();

  Map<String, String> toJson() => {
        'offset': offset.toString(),
        'ts': date.toIso8601String(),
      };
}
