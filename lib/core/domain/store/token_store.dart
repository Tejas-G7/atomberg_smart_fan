abstract class TokenStore {
  void save({required String refreshToken, required String apiKey});

  void clear();

  ({String? apiKey, String? refreshToken}) getTokens();

  void saveAccessToken(String accessToken);

  String? getAccessToken();
}
