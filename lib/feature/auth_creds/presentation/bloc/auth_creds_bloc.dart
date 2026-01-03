import 'package:atomberg_smart_fan_controller/core/domain/repository/auth_repository.dart';
import 'package:atomberg_smart_fan_controller/core/domain/store/token_store.dart';
import 'package:atomberg_smart_fan_controller/feature/auth_creds/presentation/bloc/auth_creds_event.dart';
import 'package:atomberg_smart_fan_controller/feature/auth_creds/presentation/bloc/auth_creds_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCredsBloc extends Bloc<AuthCredsEvent, AuthCredsState> {
  final TokenStore tokenStore;
  final AuthRepository authRepository;

  String _apiKey = '';
  String _refreshToken = '';

  AuthCredsBloc(this.tokenStore, this.authRepository)
    : super(const AuthCredsInitialState()) {
    on<AuthCredsApiKey>(_onApiKeyChanged);
    on<AuthCredsRefreshToken>(_onRefreshTokenChanged);
    on<AuthCredsSubmit>(_onSubmit);
  }

  void _onApiKeyChanged(AuthCredsApiKey event, Emitter<AuthCredsState> emit) {
    _apiKey = event.apiKey;
    _validateFields(_apiKey, _refreshToken, emit);
  }

  void _onRefreshTokenChanged(
    AuthCredsRefreshToken event,
    Emitter<AuthCredsState> emit,
  ) {
    _refreshToken = event.refreshToken;
    _validateFields(_apiKey, _refreshToken, emit);
  }

  Future<void> _onSubmit(
    AuthCredsSubmit event,
    Emitter<AuthCredsState> emit,
  ) async {
    final isValid = _validateFields(_apiKey, _refreshToken, emit);
    if (!isValid) return;

    emit(const AuthCredsLoadingState());

    try {
      tokenStore.save(apiKey: _apiKey, refreshToken: _refreshToken);
      await authRepository.getAccessToken();
      final isAccessTokenFetched = tokenStore.getAccessToken();
      if (isAccessTokenFetched != null) {
        emit(const AuthCredsSuccessState());
      } else {
        emit(const AuthCredsErrorState('Failed to retrieve access token'));
      }
    } catch (_) {
      emit(const AuthCredsErrorState('Failed to retrieve access token'));
    }
  }

  bool _validateFields(
    String apiKey,
    String refreshToken,
    Emitter<AuthCredsState> emit,
  ) {
    String? apiKeyError;
    String? refreshTokenError;

    if (apiKey.isEmpty) {
      apiKeyError = 'API Key cannot be empty';
    }

    if (refreshToken.isEmpty) {
      refreshTokenError = 'Refresh Token cannot be empty';
    }

    if (apiKeyError != null || refreshTokenError != null) {
      emit(
        AuthCredsFieldErrorState(
          apiKeyError: apiKeyError,
          refreshTokenError: refreshTokenError,
        ),
      );
      return false;
    }

    return true;
  }
}
