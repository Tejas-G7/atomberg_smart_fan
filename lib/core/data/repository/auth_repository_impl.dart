import 'dart:convert';
import 'dart:developer';

import 'package:atomberg_smart_fan_controller/core/constants/auth_constant.dart';
import 'package:atomberg_smart_fan_controller/core/constants/response_status.dart';
import 'package:atomberg_smart_fan_controller/core/data/model/access_token_dto.dart';
import 'package:atomberg_smart_fan_controller/core/domain/repository/auth_repository.dart';
import 'package:atomberg_smart_fan_controller/core/domain/store/token_store.dart';
import 'package:atomberg_smart_fan_controller/core/network/atomberg_client.dart';

class AuthRepositoryImpl extends AuthRepository {
  final TokenStore tokenStore;
  final AtombergClient client;

  AuthRepositoryImpl(this.tokenStore, this.client);

  @override
  Future<void> getAccessToken() async {
    try {
      final response = await client.get(
        Uri.parse(AuthConstant.baseUrl + AuthConstant.getAccessToken),
      );
      if (response.statusCode == ResponseStatus.success.code) {
        final accessTokenDTO = AccessTokenDTO.toDTO(jsonDecode(response.body));
        if (accessTokenDTO.status == AuthConstant.isSuccess) {
          tokenStore.saveAccessToken(accessTokenDTO.toDomain().token);
        }
      } else {
        log(
          "There is an error while fetching the access token ${response.statusCode}",
        );
      }
    } catch (e) {
      log("Unable to get access token $e");
    }
  }
}
