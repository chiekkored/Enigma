import 'dart:convert';

class SampleModel {
  late final String test1;
  late final String test2;
  SampleModel({
    required this.test1,
    required this.test2,
  });

  SampleModel copyWith({
    String? test1,
    String? test2,
  }) {
    return SampleModel(
      test1: test1 ?? this.test1,
      test2: test2 ?? this.test2,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'test1': test1});
    result.addAll({'test2': test2});

    return result;
  }

  factory SampleModel.fromMap(Map<String, dynamic> map) {
    return SampleModel(
      test1: map['test1'] ?? '',
      test2: map['test2'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SampleModel.fromJson(String source) =>
      SampleModel.fromMap(json.decode(source));

  @override
  String toString() => 'SampleModel(test1: $test1, test2: $test2)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SampleModel && other.test1 == test1 && other.test2 == test2;
  }

  @override
  int get hashCode => test1.hashCode ^ test2.hashCode;
}
