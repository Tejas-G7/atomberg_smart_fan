import '../../domain/store/token_store.dart';

class TokenStoreImpl extends TokenStore {
  String? _apiKey;
  String? _refreshToken;
  String? _accessToken;

  TokenStoreImpl._internal();

  static final TokenStoreImpl _instance = TokenStoreImpl._internal();

  factory TokenStoreImpl() {
    return _instance;
  }

  @override
  void save({required String refreshToken, required String apiKey}) {
    _apiKey = apiKey;
    _refreshToken = refreshToken;
  }

  @override
  void clear() {
    _apiKey = null;
    _refreshToken = null;
  }

  @override
  ({String? apiKey, String? refreshToken}) getTokens() {
    return (apiKey: _apiKey, refreshToken: _refreshToken);
  }

  @override
  String? getAccessToken() {
    return _accessToken;
  }

  @override
  void saveAccessToken(String accessToken) {
    _accessToken = accessToken;
  }
}
