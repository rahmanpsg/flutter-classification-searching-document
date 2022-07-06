class ClassificationReportModel {
  final String kategori;
  final num precision;
  final num recall;
  final num f1Score;
  final num support;

  ClassificationReportModel({
    required this.kategori,
    required this.precision,
    required this.recall,
    required this.f1Score,
    required this.support,
  });

  factory ClassificationReportModel.fromJson(Map<String, dynamic> json) {
    return ClassificationReportModel(
      kategori: json['kategori'],
      precision: json['precision'],
      recall: json['recall'],
      f1Score: json['f1-score'],
      support: json['support'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kategori': kategori,
      'precision': precision,
      'recall': recall,
      'f1_score': f1Score,
      'support': support,
    };
  }

  @override
  String toString() {
    return 'ClassificationReportModel{kategori: $kategori, precision: $precision, recall: $recall, f1Score: $f1Score, support: $support}';
  }
}
