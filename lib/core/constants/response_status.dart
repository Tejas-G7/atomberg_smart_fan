enum ResponseStatus {
  success(200, 'OK'),
  unauthorized(401, 'Access token has expired'),
  forbidden(403, 'Developer mode is disabled'),
  notFound(404, 'Invalid device connection'),
  tooManyRequest(429, 'Hit API limit');

  final int code;
  final String message;

  const ResponseStatus(this.code, this.message);
}

extension StatusCodeHint on int {
  String get statusCodeHint {
    return switch (this) {
      200 => ResponseStatus.success.message,
      401 => ResponseStatus.unauthorized.message,
      403 => ResponseStatus.forbidden.message,
      404 => ResponseStatus.notFound.message,
      429 => ResponseStatus.tooManyRequest.message,
      _ => 'Something went wrong',
    };
  }
}
