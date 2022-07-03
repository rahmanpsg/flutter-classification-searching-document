class HasilTfIdfModel {
  final String keyword;
  final int count;
  final double tf;
  final double idf;
  final double tfIdf;

  HasilTfIdfModel({
    required this.keyword,
    required this.count,
    required this.tf,
    required this.idf,
    required this.tfIdf,
  });

  factory HasilTfIdfModel.fromJson(Map<String, dynamic> json) {
    return HasilTfIdfModel(
      keyword: json['keyword'] as String,
      count: json['count'] as int,
      tf: json['tf'] as double,
      idf: json['idf'] as double,
      tfIdf: json['tf_idf'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'keyword': keyword,
      'count': count,
      'tf': tf,
      'idf': idf,
      'tfIdf': tfIdf,
    };
  }

  @override
  String toString() {
    return 'HasilTfIdfModel{keyword: $keyword, count: $count, tf: $tf, idf: $idf, tfIdf: $tfIdf}';
  }
}
