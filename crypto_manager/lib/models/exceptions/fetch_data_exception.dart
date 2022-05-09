class FetchDataException implements Exception {
  final String? _message;

  FetchDataException(this._message);

  @override
  String toString() {
    if (_message == null || _message!.isEmpty) return "Exception";
    return "Exception: $_message";
  }
}
