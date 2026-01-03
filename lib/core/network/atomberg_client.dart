import 'dart:convert';
import 'dart:developer';

import 'package:atomberg_smart_fan_controller/core/constants/auth_constant.dart';
import 'package:atomberg_smart_fan_controller/core/domain/store/token_store.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AtombergClient extends http.BaseClient {
  AtombergClient(this.tokenStore) : _inner = http.Client();

  final TokenStore tokenStore;
  final http.Client _inner;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final (:apiKey, :refreshToken) = tokenStore.getTokens();
    final accessToken = tokenStore.getAccessToken();
    request.headers[AuthConstant.apiKey] = '$apiKey';
    if (accessToken != null) {
      request.headers[AuthConstant.authorization] =
          '${AuthConstant.bearer} $accessToken';
    } else {
      request.headers[AuthConstant.authorization] =
          '${AuthConstant.bearer} $refreshToken';
    }

    if (kDebugMode) {
      log("||--->${request.method} ${request.url}");
      log("||Headers: ${request.headers}");
      if (request is http.Request) {
        log('||Body: ${request.body}');
      } else if (request is http.MultipartRequest) {
        log('||Fields: ${request.fields}');
      }
      final response = await _inner.send(request);

      final body = await response.stream.bytesToString();

      log("||||--->${response.statusCode} ${request.url}");
      log("||||Response: $body");
      final newStream = Stream.value(utf8.encode(body));
      return http.StreamedResponse(
        newStream,
        response.statusCode,
        request: response.request,
        headers: response.headers,
        reasonPhrase: response.reasonPhrase,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
      );
    }
    return await _inner.send(request);
  }
}
