class Result<T, E> {
  final T? success;
  final E? error;

  Result._({this.error, this.success});

  factory Result.success(T success) => Result._(success: success);

  factory Result.error(E error) => Result._(error: error);

  bool get isSuccess => success != null;
}
