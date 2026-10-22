import 'package:dart_pi/src/model/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_completion_request.freezed.dart';
part 'chat_completion_request.g.dart';

@freezed
abstract class ChatCompletionRequest with _$ChatCompletionRequest {
  const factory ChatCompletionRequest({
    required String model,
    required List<Message> messages,
  }) = _ChatCompletionRequest;

  factory ChatCompletionRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionRequestFromJson(json);
}
