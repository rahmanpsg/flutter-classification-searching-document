class ResponseApiModel<T> {
  bool error;
  String message;
  Map<String, dynamic>? errors;
  T? data;

  ResponseApiModel({
    required this.error,
    this.message = '',
    this.errors,
    this.data,
  });

  factory ResponseApiModel.fromJson(Map<String, dynamic> json) {
    return ResponseApiModel(
      error: json['error'] as bool,
      message: json['message'] ?? "",
      errors: json['errors'],
      data: json['data'],
    );
  }

  String get errorMessage {
    if (error) {
      if (errors != null) {
        return errors!.entries
            .map((error) =>
                "${error.key.toUpperCase()}: ${error.value.toString().toUpperCase()}")
            .join("\n");
      } else {
        return message;
      }
    } else {
      return "";
    }
  }
}
