class UniversalResponse {
  UniversalResponse({
    this.error = "",
    this.data,
    this.statusCode = 0,
  });

  dynamic data;
  int statusCode;
  String error;
}