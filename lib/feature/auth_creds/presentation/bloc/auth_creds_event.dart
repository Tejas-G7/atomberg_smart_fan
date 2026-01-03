abstract class AuthCredsEvent {}

class AuthCredsApiKey extends AuthCredsEvent {
  final String apiKey;

  AuthCredsApiKey(this.apiKey);
}

class AuthCredsRefreshToken extends AuthCredsEvent {
  final String refreshToken;

  AuthCredsRefreshToken(this.refreshToken);
}

class AuthCredsSubmit extends AuthCredsEvent {
  final String apiKey;
  final String refreshToken;

  AuthCredsSubmit({required this.apiKey, required this.refreshToken});
}
