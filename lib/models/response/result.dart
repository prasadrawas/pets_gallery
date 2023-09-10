class Result<T> {
  final T? data;
  final dynamic error;

  Result({this.data, this.error});

  bool get isSuccess => data != null;

  bool get isError => error != null;
}
