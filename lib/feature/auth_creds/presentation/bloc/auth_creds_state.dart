abstract class AuthCredsState {
  const AuthCredsState();
}

class AuthCredsInitialState extends AuthCredsState {
  const AuthCredsInitialState();
}

class AuthCredsLoadingState extends AuthCredsState {
  const AuthCredsLoadingState();
}

class AuthCredsSuccessState extends AuthCredsState {
  const AuthCredsSuccessState();
}

class AuthCredsSubmitState extends AuthCredsState {
  final String apiKey;
  final String refreshToken;

  const AuthCredsSubmitState({
    required this.apiKey,
    required this.refreshToken,
  });
}

class AuthCredsFieldErrorState extends AuthCredsState {
  final String? apiKeyError;
  final String? refreshTokenError;

  const AuthCredsFieldErrorState({this.apiKeyError, this.refreshTokenError});
}

class AuthCredsErrorState extends AuthCredsState {
  final String message;

  const AuthCredsErrorState(this.message);
}
