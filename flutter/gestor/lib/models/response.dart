class Response {
  final String message;
  final Map<String, dynamic> errors;

  const Response({this.message = '', this.errors = const {}});

  factory Response.fromJson(Map<String, dynamic> data) {
    return Response(
      message: data['message'] ?? 'NULL MESSAGE',
      errors: data['errors'] ?? {},
    );
  }

  String? getError(String field) {
    if (errors[field].runtimeType == List) {
      return (errors[field] as List).first;
    }
    return null;
  }
}
