import '../../domain/entity/access_token.dart';

class AccessTokenDTO {
  final String status;
  final Message message;

  AccessTokenDTO({required this.status, required this.message});

  factory AccessTokenDTO.toDTO(Map<String, dynamic> data) {
    return AccessTokenDTO(
      status: data["status"],
      message: Message.toDTO(data["message"]),
    );
  }

  AccessToken toDomain() {
    return AccessToken(message.accessToken);
  }
}

class Message {
  final String accessToken;

  Message({required this.accessToken});

  factory Message.toDTO(Map<String, dynamic> data) {
    return Message(accessToken: data["access_token"]);
  }
}
